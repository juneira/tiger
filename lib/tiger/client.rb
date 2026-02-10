# frozen_string_literal: true

require 'forwardable'
require_relative 'const'

module Tiger
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

    def initialize(tcp_client)
      @tcp_client = tcp_client
      @env = DEFAULT_ENV
    end
  end
end
