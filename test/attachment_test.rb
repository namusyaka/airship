require File.expand_path('../../lib/airship/attachment', __FILE__)
$:.unshift(File.dirname(__FILE__))
require 'helper'

describe Airship::Attachment do
  context Sinatra do
    describe :to do
      before do
        mock_app Sinatra::Base do
          register Airship::Attachment::Sinatra

          def hello
            "Hello World"
          end
  
          def show(id, type)
            "id: #{id}, type: #{type}"
          end
  
          def hey
            @a
          end
  
          def bar
            @b = "bar"
          end
  
          def show_bar
            @b
          end
  
          get "/", to: :hello
          get "/show/:id/:type", to: :show
  
          before("/foo"){ @a = "hey" }
          get "/foo", to: :hey
  
          before "/bar", to: :bar
          get "/bar", to: :show_bar
        end
      end
  
      it "can be attached to instance method" do
        get '/'
        assert_equal 'Hello World', last_response.body
      end
  
      it "can take the captures" do
        get '/show/1234/frank'
        assert_equal 'id: 1234, type: frank', last_response.body
      end

      it "can treat the instance variable" do
        get '/foo'
        assert_equal 'hey', last_response.body
      end

      it "can be attached to instance method with the filters" do
        get '/bar'
        assert_equal 'bar', last_response.body
      end

      it "occurs UndefinedMethod error if method is undefined" do
        assert_raises Airship::Attachment::UndefinedMethod do
          mock_app(Sinatra::Base) do
            register Airship::Attachment::Sinatra
            get "/dummy", to: :undefined
          end
        end
        assert_raises Airship::Attachment::UndefinedMethod do
          mock_app(Sinatra::Base) do
            register Airship::Attachment::Sinatra
            before "/dummy", to: :undefined
          end
        end
      end
    end
  end

  context Padrino do
    describe :to do
      before do
        Padrino::Application.send(:register, Airship::Attachment::Padrino)
        mock_app do
          def hello
            "Hello World"
          end
  
          def show(id, type)
            "id: #{id}, type: #{type}"
          end

          def hey
            @a
          end

          def bar
            @b = "bar"
          end

          def show_bar
            @b
          end
  
          get :index, to: :hello
          get :show, "/show/:id/:type", to: :show

          before(:foo){ @a = "hey" }
          get :foo, to: :hey

          before :bar, to: :bar
          get :bar, to: :show_bar
        end
      end
  
      it "can be attached to instance method" do
        get '/'
        assert_equal 'Hello World', last_response.body
      end
  
      it "can take the captures" do
        get '/show/1234/frank'
        assert_equal 'id: 1234, type: frank', last_response.body
      end

      it "can treat the instance variable" do
        get '/foo'
        assert_equal 'hey', last_response.body
      end

      it "can be attached to instance method with the filters" do
        get '/bar'
        assert_equal 'bar', last_response.body
      end

      it "occurs UndefinedMethod error if method is undefined" do
        assert_raises Airship::Attachment::UndefinedMethod do
          mock_app{ get :dummy, to: :undefined }
        end
        assert_raises Airship::Attachment::UndefinedMethod do
          mock_app{ before :dummy, to: :undefined }
        end
      end
    end
  end
end
