# frozen_string_literal: true

require_relative 'const'

module Tiger
  # This module is included by Server
  module Request
    include Const

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

