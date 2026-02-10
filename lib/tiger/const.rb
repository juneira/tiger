# frozen_string_literal: true

module Tiger
  module Const
    # CGI Variables
    SCRIPT_NAME     = 'SCRIPT_NAME'
    SERVER_NAME     = 'SERVER_NAME'
    SERVER_PROTOCOL = 'SERVER_PROTOCOL'
    REQUEST_METHOD  = 'REQUEST_METHOD'
    PATH_INFO       = 'PATH_INFO'
    QUERY_STRING    = 'QUERY_STRING'
    SERVER_PORT     = 'SERVER_PORT'

    # Rack-Specific Variables
    RACK_VERSION      = 'rack.version'
    RACK_URL_SCHEME   = 'rack.url_scheme'
    RACK_ERRORS       = 'rack.errors'
    RACK_MULTITHREAD  = 'rack.multithread'
    RACK_MULTIPROCESS = 'rack.multiprocess'
    RACK_RUN_ONCE     = 'rack.run_once'
    RACK_INPUT        = 'rack.input'
  end
end
