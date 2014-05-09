
module Airship
  module Attachment
    ##
    #  Airship::Attachment enables to use :to option with verb methods
    #
    #  @example Sinatra
    #
    #    class Sample < Sinatra::Base
    #      register Airship::Attachment::Sinatra
    #
    #      def hello
    #        "Hello World"
    #      end
    #
    #      def show(id)
    #        "This is #{id}"
    #      end
    #
    #      get "/",    to: :hello
    #      get "/:id", to: :show
    #    end
    #
    #  @example Padrino
    #
    #    class Sample < Padrino::Application
    #      register Airship::Attachment::Padrino
    #
    #      def hello
    #        "Hello World"
    #      end
    #
    #      def show(id)
    #        "This is #{id}"
    #      end
    #
    #      get :index, to: :hello
    #      get :show,  with: :id, to: :show
    #    end
    #
    UndefinedMethod = Class.new(ArgumentError)

    autoload :Sinatra, "airship/attachment/sinatra"
    autoload :Padrino, "airship/attachment/padrino"
  end
end
