# frozen_string_literal: true

require_relative 'client'
require_relative 'request'

module Tiger
  class Server
    include Request

    def initialize(app, port: 8080)
      @app = app
      @tcp_server = TCPServer.new('localhost', port)
    end

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
      client.print "HTTP/1.1 #{status}"
      headers.each { |k, v| client.print "#{k}: #{v}\r\n" }
      client.print "\r\n"
      body.each { |part| client.print part }
    end
  end
end
