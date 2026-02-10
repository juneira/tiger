# frozen_string_literal: true

require_relative 'const'

module Tiger
  # Parses incoming HTTP requests and builds the Rack environment.
  # Include this module in any class that needs to translate raw HTTP data
  # into a Rack-compatible +env+ hash and invoke a Rack application.
  # The including class must provide +app+ (a Rack app) and +@tcp_server+.
  module Request
    include Const

    # Reads the first line of the HTTP request from +client+, extracts the
    # method and path, populates the Rack environment, and calls the Rack
    # app. Returns the standard Rack response triplet: [status, headers, body].
    #
    #   status, headers, body = receive_request(client)
    def receive_request(client)
      request = client.gets

      input = StringIO.new(''.b)
      input.set_encoding(Encoding::BINARY)

      client.env[REQUEST_METHOD] = request.split[0]
      client.env[PATH_INFO] = request.split[1]
      client.env[QUERY_STRING] = ''
      client.env[SERVER_PORT] = @tcp_server.addr[1].to_s
      client.env[RACK_INPUT] = input

      app.call(client.env)
    end
  end
end

