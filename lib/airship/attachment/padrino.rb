require_relative '../extensions/padrino'

module Airship
  module Attachment
    module Padrino

      def self.registered(app)
        app.extend ClassMethods
      end

      module ClassMethods
        include Airship::Extensions::Padrino
        
        def construct_filter(*args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          name = options.delete(:to)

          if name.instance_of?(Symbol) && !block_given?
            unbound_method = instance_method(name) rescue undefined_method(name)
            block = proc{ unbound_method.bind(self).call }
          end

          except = options.key?(:except) && Array(options.delete(:except))
          raise("You cannot use except with other options specified") if except && (!args.empty? || !options.empty?)
          options = except.last.is_a?(Hash) ? except.pop : {} if except
          ::Padrino::Filter.new(!except, @_controller, options, Array(except || args), &block)
        end
  
        def generate_unbound_method(verb, path, options, &block)
          name = options.delete(:to)
          if name.instance_of?(Symbol) && !block_given?
            instance_method(name) rescue undefined_method(name)
          else
            super
          end
        end
  
        private
  
        def undefined_method(name)
          raise UndefinedMethod, "undefined method `#{name}`."
        end
      end
    end
  end
end
