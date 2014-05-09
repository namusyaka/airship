# Airship

Airship is the Sinatra/Padrino extension.

## Installation

Add this line to your application's Gemfile:

    gem 'airship'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install airship

## Usage

### Attachment

Airship::Attachment enables to use :to option with verbs and filters

#### with Sinatra

```ruby
class Sample::App < Sinatra::Base
  register Airship::Attachment::Sinatra

  def before_index
    @hello = :Hello
  end

  def index
    "#{@hello} World"
  end

  def show(name, type)
    "#{name} is #{type}"
  end

  before "/", to: :before_index

  get "/", to: :index
  get "/show/:name/:type", to: :show

end
```

#### with Padrino

```ruby
class Sample::App < Padrino::Application
  register Airship::Attachment::Padrino

  def before_index
    @hello = :Hello
  end

  def index
    "#{@hello} World"
  end

  def show(name, type)
    "#{name} is #{type}"
  end

  before :index, to: :before_index
  get :index, to: :index
  get :show, map: "/show/:name/:type", to: :show

end
```

### Management

Airship::Management provides yet another DSL built upon the Sinatra/Padrino library.

#### with Sinatra

```ruby
class Sample::App < Sinatra::Base
  register Airship::Management::Sinatra

  index do
    "GET /"
  end

  show do
    "GET /:id"
  end

  edit do
    "GET /:id/edit"
  end

  update do
    "POST /:id/update"
  end

  destroy do
    "DELETE /:id/delete"
  end
end
```

#### with Padrino

```ruby
class Sample::App < Padrino::Application
  register Airship::Management::Padrino

  index do
    "GET /"
  end

  show do
    "GET /:id"
  end

  edit do
    "GET /:id/edit"
  end

  update do
    "POST /:id/update"
  end

  destroy do
    "DELETE /:id/delete"
  end

  controller :resources do
    index do
      "GET /resources"
    end
  
    show do
      "GET /resources/:id"
    end
  
    edit do
      "GET /resources/:id/edit"
    end
  
    update do
      "POST /resources/:id/update"
    end
  
    destroy do
      "DELETE /resources/:id/delete"
    end
  end
end
```

## Contributing

1. Fork it ( https://github.com/namusyaka/airship/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
