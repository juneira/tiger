# frozen_string_literal: true

require 'forwardable'
require_relative 'const'

module Tiger
  # Wraps a raw TCP socket into a Rack-aware client. It holds the Rack
  # environment hash and delegates I/O operations to the underlying socket.
  # Use this class to turn an accepted TCP connection into something the
  # request pipeline can work with.
  #
  #   client = Tiger::Client.new(tcp_server.accept)
  #   client.gets   # read a line from the socket
  #   client.env    # access the Rack environment hash
  #   client.close  # close the connection
  class Client
    extend Forwardable
    include Const

    DEFAULT_ENV = {
      SCRIPT_NAME => '',
      SERVER_NAME => 'localhost',
      SERVER_PROTOCOL => 'HTTP/1.1',
      RACK_VERSION => [1, 3],
      RACK_URL_SCHEME => 'http',
      RACK_ERRORS => $stderr,
      RACK_MULTITHREAD => false,
      RACK_MULTIPROCESS => false,
      RACK_RUN_ONCE => false
    }

    attr_reader :tcp_client, :env

    def_delegators :tcp_client, :gets, :print, :close

    # Wraps +tcp_client+ (a TCPSocket returned by TCPServer#accept) and
    # initializes a default Rack environment hash that will be populated
    # later by the Request module with per-request values.
    def initialize(tcp_client)
      @tcp_client = tcp_client
      @env = DEFAULT_ENV
    end
  end
end
