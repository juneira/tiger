# frozen_string_literal: true

require 'socket'
require 'stringio'

module Tiger
  class Server
    def initialize(app, port: 8080)
      @app = app
      @tcp_server = TCPServer.new('localhost', port)
    end

    def run
      loop do
        client = tcp_server.accept

        status, headers, body = receive_request(client)
        send_response(client, status, headers, body)

        client.close
      end
    end

    private

    attr_reader :app, :tcp_server

    def receive_request(client)
      request = client.gets

      input = StringIO.new(''.b)
      input.set_encoding(Encoding::BINARY)

      env = {
        'REQUEST_METHOD' => request.split[0],
        'SCRIPT_NAME' => '',
        'PATH_INFO' => request.split[1],
        'QUERY_STRING' => '',
        'SERVER_NAME' => 'localhost',
        'SERVER_PORT' => @tcp_server.addr[1].to_s,
        'SERVER_PROTOCOL' => 'HTTP/1.1',
        'rack.version' => [1, 3],
        'rack.url_scheme' => 'http',
        'rack.input' => input,
        'rack.errors' => $stderr,
        'rack.multithread' => false,
        'rack.multiprocess' => false,
        'rack.run_once' => false
      }

      app.call(env)
    end

    def send_response(client, status, headers, body)
      client.print "HTTP/1.1 #{status}"
      headers.each { |k, v| client.print "#{k}: #{v}\r\n" }
      client.print "\r\n"
      body.each { |part| client.print part }
    end
  end
end
