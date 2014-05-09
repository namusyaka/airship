module Airship
  module Management
    module Padrino
      def self.registered(app)
        app.extend ClassMethods
      end

      module ClassMethods
        def index(options = {}, &block)
          get :index, "", options, &block
        end

        def show(options = {}, &block)
          get :show, ":id", options, &block
        end

        def edit(options = {}, &block)
          get :edit, ":id/edit", options, &block
        end

        def update(options = {}, &block)
          post :update, ":id/update", options, &block
        end

        def destroy(options = {}, &block)
          delete :destroy, ":id/destroy", options, &block
        end
      end
    end
  end
end
