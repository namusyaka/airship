module Airship
  module Management
    module Sinatra
      def self.registered(app)
        app.extend ClassMethods
      end

      module ClassMethods
        def index(options = {}, &block)
          get "/", options, &block
        end

        def show(options = {}, &block)
          get "/:id", options, &block
        end

        def edit(options = {}, &block)
          get "/:id/edit", options, &block
        end

        def update(options = {}, &block)
          post "/:id/update", options, &block
        end

        def destroy(options = {}, &block)
          delete "/:id/destroy", options, &block
        end
      end
    end
  end
end
