
module Airship
  module Management
    ##
    #  Airship::Management provides some useful methods for use in an environment like CRUD
    #
    #  @example Sinatra
    #
    #    class Sample < Sinatra::Base
    #      register Airship::Management::Sinatra
    #
    #      index do
    #        "GET /"
    #      end
    #  
    #      show do
    #        "GET /:id"
    #      end
    #  
    #      edit do
    #        "GET /edit/:id"
    #      end
    #  
    #      update do
    #        "POST /update/:id"
    #      end
    #  
    #      destroy do
    #        "POST /destroy/:id"
    #      end
    #    end
    #
    #  @example Padrino
    #
    #    class Sample < Padrino::Application
    #      register Airship::Attachment::Padrino
    #      
    #      controller :article do
    #        index do
    #          "GET /article"
    #        end
    #  
    #        show do
    #          "GET /article/:id"
    #        end
    #  
    #        edit do
    #          "GET /article/edit/:id"
    #        end
    #   
    #        update provides: [:xml, :json] do
    #          "PUT /article/update/:id.(:format)"
    #        end
    #  
    #        destroy provides: [:xml, :json] do
    #          "DELETE /article/destroy/:id.(:format)"
    #        end
    #      end
    #    end
    #

    autoload :Sinatra, "airship/management/sinatra"
    autoload :Padrino, "airship/management/padrino"
  end
end
