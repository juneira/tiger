# frozen_string_literal: true

require_relative 'client'
require_relative 'request'

module Tiger
  # The core of Tiger, responsible for accepting TCP connections and
  # processing HTTP requests through a Rack application. Use this class
  # when you need a lightweight, single-threaded web server that speaks
  # the Rack interface.
  #
  #   app = Rack::Builder.parse_file('config.ru')
  #   server = Tiger::Server.new(app, port: 3000)
  #   server.run
  class Server
    include Request

    # Creates a new server bound to localhost on the given port.
    # +app+ must be a valid Rack application (any object responding to +call+).
    # The server starts listening immediately upon initialization.
    #
    #   server = Tiger::Server.new(my_rack_app, port: 9292)
    def initialize(app, port: 8080)
      @app = app
      @tcp_server = TCPServer.new('localhost', port)
    end

    # Starts the main accept loop. For each incoming connection it reads the
    # HTTP request, passes it to the Rack app, writes the response back, and
    # closes the connection. This method blocks indefinitely.
    def run
      loop do
        client = Client.new(tcp_server.accept)

        status, headers, body = receive_request(client)
        send_response(client, status, headers, body)

        client.close
      end
    end

    private

    attr_reader :app, :tcp_server

    def send_response(client, status, headers, body)
      client.print "HTTP/1.1 #{status}\r\n"
      headers.each { |k, v| client.print "#{k}: #{v}\r\n" }
      client.print "\r\n"
      body.each { |part| client.print part }
    ensure
      body.close if body.respond_to?(:close)
    end
  end
end
