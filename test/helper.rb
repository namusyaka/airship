require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require 'sinatra/base'
require 'padrino-core'

class Sinatra::Base
  include MiniTest::Assertions
end

class MiniTest::Spec
  include Rack::Test::Methods

  class << self
    alias context describe
  end

  def app
    Rack::Lint.new(@app)
  end

  def mock_app(base = Padrino::Application, &block)
    @app = Sinatra.new(base, &block)
    @app.set :logging, false
  end
end
