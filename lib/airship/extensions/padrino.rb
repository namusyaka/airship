module Airship
  module Extensions
    module Padrino
      ##
      # Airship::Extensions::Padrino separates methods of Padrino::Routing to convenient size.

      ROUTE_PRIORITY = {:high => 0, :normal => 1, :low => 2} unless defined?(ROUTE_PRIORITY)

      def route(verb, path, *args, &block)
        options = extract_options(args)
        route_options = build_route_options(options)
        path, *route_options[:with] = path if path.is_a?(Array)
        action = path
        path, name, route_parents, options, route_options = *parse_route(path, route_options, verb)
        options.reverse_merge!(@_conditions) if @_conditions
        block = generate_block(verb, path, options, block)
        options.merge!(name: name, route_options: route_options, parents: route_parents, action: action)
        register_route(verb, path, args, options, &block)
      end

      private

      def register_route(verb, path, args, options, &block)
        route = router.add(path, options.delete(:route_options))
        route.action = options.delete(:action)
        route.add_request_method(verb.downcase.to_sym)
        invoke_hook(:route_added, verb, path, block)

        priority_name = options.delete(:priority) || :normal
        priority = ROUTE_PRIORITY[priority_name] or raise("Priority #{priority_name} not recognized, try #{ROUTE_PRIORITY.keys.join(', ')}")
        deferred_routes[priority] << [set_parameters(route, options), block]

        # for page caching
        invoke_hook(:padrino_route_added, route, verb, path, args, options, block)
      end

      def set_parameters(route, options)
        route.name = options.delete(:name)
        route.cache = options.key?(:cache) ? options.delete(:cache) : @_cache if options.key?(:cache)
        route.user_agent = options.delete(:agent) if options.key?(:agent)
        route.host = options.delete(:host) if options.key?(:host)

        if @_controller
          route.use_layout = @layout
          route.controller = Array(@_controller).join('/')
        end

        parents = options.delete(:parents)
        route.parent = parents ? (parents.count == 1 ? parents.first : parents) : parents

        if options.key?(:default_values)
          defaults = options.delete(:default_values)
          route.add_default_values(defaults) if defaults
        end

        options.delete_if do |option, args|
          if route.significant_variable_names.include?(option)
            route.add_match_with(option => Array(args).first)
            true
          end
        end

        options.each{|o, a| route.respond_to?(o) ? route.send(o, *a) : send(o, *a) }
        conditions, @conditions = @conditions, []
        route.custom_conditions.concat(conditions)
        route.before_filters << @filters[:before]
        route.after_filters << @filters[:after]
        route
      end

      def generate_unbound_method(verb, path, options, &block)
        method_name = "#{verb} #{path}"
        generate_method(method_name, &block)
      end

      def generate_block(verb, path, options, block)
        unbound_method = generate_unbound_method(verb, path, options, &block)
        unbound_method.arity != 0 ?
          proc{|a, p| unbound_method.bind(a).call(*p) } :
          proc{|a, p| unbound_method.bind(a).call }
      end


      def build_route_options(options)
        route_options = options.dup
        [:provides, :accepts].each{|name|
          (var = instance_variable_get(:"@_#{name}")) && (route_options[name] = var) }
        unless route_options.has_key?(:csrf_protection)
          route_options[:csrf_protection] = true
        end if protect_from_csrf && (report_csrf_failure || allow_disabled_csrf)
        route_options
      end

      def extract_options(args)
        case args.size
        when 2
          args.last.merge(map: args.first)
        when 1
          map = args.shift if args.first.is_a?(String)
          if args.first.is_a?(Hash)
            map ? args.first.merge(map: map) : args.first
          else
            { map: map || args.first }
          end
        when 0
          {}
        else raise
        end
      end
    end
  end
end
