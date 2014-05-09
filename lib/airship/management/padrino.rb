module Airship
  module Management
    module Padrino
      def self.registered(app)
        app.extend ClassMethods
      end

      module ClassMethods
        def index(options = {}, &block)
          route 'GET', "", options, &block
        end

        def show(options = {}, &block)
          route 'GET', ":id", options, &block
        end

        def edit(options = {}, &block)
          route 'GET', ":id/edit", options, &block
        end

        def update(options = {}, &block)
          route 'POST', ":id/update", options, &block
        end

        def destroy(options = {}, &block)
          route 'DELETE', ":id/destroy", options, &block
        end
      end
    end
  end
end
