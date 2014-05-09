require File.expand_path('../../lib/airship/management', __FILE__)
$:.unshift(File.dirname(__FILE__))
require 'helper'

describe Airship::Management do
  context Sinatra do
    describe :routing do
      before do
        mock_app Sinatra::Base do
          register Airship::Management::Sinatra

          index { "index!" }
          show { "show #{params[:id]}" }
          edit { "edit #{params[:id]}" }
          update { "update #{params[:id]}" }
          destroy { "destroy #{params[:id]}" }

          get("/hey/ho"){ "Hey" }
        end
      end

      it "can be used to define the regular routes" do
        get "/"
        assert_equal "index!", last_response.body
        get "/1234"
        assert_equal "show 1234", last_response.body
        get "/5678/edit"
        assert_equal "edit 5678", last_response.body
        post "/5678/update"
        assert_equal "update 5678", last_response.body
        delete "/5678/destroy"
        assert_equal "destroy 5678", last_response.body
      end

      it "should not break the compatibility with sinatra" do
        get "/hey/ho"
        assert_equal "Hey", last_response.body
      end
    end
  end

  context Padrino do
    describe :routing do
      before do
        mock_app do
          register Airship::Management::Padrino

          index { "index!" }
          show { "show #{params[:id]}" }
          edit { "edit #{params[:id]}" }
          update { "update #{params[:id]}" }
          destroy { "destroy #{params[:id]}" }

          get(:heyho, map: "/hey/ho"){ "Hey" }

          controller :resources do
            show { "resource show #{params[:id]}" }
            edit { "resource edit #{params[:id]}" }
          end
        end
      end

      it "can be used to define the regular routes" do
        get "/"
        assert_equal "index!", last_response.body
        get "/1234"
        assert_equal "show 1234", last_response.body
        get "/5678/edit"
        assert_equal "edit 5678", last_response.body
        post "/5678/update"
        assert_equal "update 5678", last_response.body
        delete "/5678/destroy"
        assert_equal "destroy 5678", last_response.body
      end

      it "should not break the compatibility with padrino" do
        get "/hey/ho"
        assert_equal "Hey", last_response.body
      end

      it "should be able to use it on the controller" do
        get "/resources/1234"
        assert_equal "resource show 1234", last_response.body
        get "/resources/1234/edit"
        assert_equal "resource edit 1234", last_response.body
      end
    end
  end
end
