# Tiger Web Server

Tiger is a simple web server built with Ruby and designed to integrate with the Rack interface. It provides a basic implementation of a server using Ruby's standard `TCPServer` to handle HTTP requests and responses.

## Features

* **Rack Integration**: Includes a handler to run Rack-based applications.
* **Simple Architecture**: Built using standard Ruby libraries like `socket` and `stringio`.
* **Autoloading**: Utilizes Ruby's `autoload` for efficient memory usage.

## Installation

Ensure you have Ruby 3.0 or higher installed, as specified in the project's linting configuration.

1. Clone the repository.
2. Install dependencies using Bundler:
```bash
bundle install

```


*Note: The project requires `rack` version ~> 3.2.*

## Usage

### Basic Example

You can run a simple "Hello Tiger!" application using the provided example configuration. Create or use an existing `config.ru` file:

```ruby
require 'rack'
require 'tiger'

app = Rack::Builder.new do
  run ->(env) do
    [200, {'content-type' => 'text/plain'}, ['Hello Tiger!']]
  end
end

run app

```

### Starting the Server

The server defaults to port `8080` on `localhost`. You can initialize and run the server manually within a Ruby script:

```ruby
require 'tiger'

server = Tiger::Server.new(your_rack_app, port: 8080)
server.run

```

## Development

The project uses RuboCop for code style and performance linting. To run the linter:

```bash
bundle exec rubocop

```

Excluded directories include `tmp`, `vendor`, and `examples`.

## License

This project is licensed under the MIT License.

Copyright (c) 2026 Marcelo Junior.
