
module Airship
  module Attachment
    module Sinatra

      def self.registered(app)
        app.extend ClassMethods
      end

      module ClassMethods
        def compile!(verb, path, block, options = {})
          options = options.dup

          if method_name = options.delete(:to)
            block = unbound_method = instance_method(method_name) rescue undefined_method(method_name)
          else
            method_name = "#{verb} #{path}"
            unbound_method = generate_method(method_name, &block)
          end

          options.each_pair { |option, args| send(option, *args) }
          pattern, keys = compile path
          conditions, @conditions = @conditions, []
  
          wrapper = block.arity != 0 ?
            proc { |a,p| unbound_method.bind(a).call(*p) } :
            proc { |a,p| unbound_method.bind(a).call }
          wrapper.instance_variable_set(:@route_name, method_name)
  
          [ pattern, keys, conditions, wrapper ]
        end
  
        private
  
        def undefined_method(name)
          raise UndefinedMethod, "undefined method `#{name}`."
        end
      end
    end
  end
end
