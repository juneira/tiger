require_relative '../../tiger'

module Rackup
  module Handler
    # Rackup handler that lets you boot Tiger with the +rackup+ CLI.
    # Register it so Rackup can discover Tiger by name:
    #
    #   $ rackup -s tiger config.ru
    module Tiger
      class << self
        # Entry point called by Rackup. Receives the Rack +app+ built from
        # config.ru and any CLI options, then starts the Tiger server.
        def run(app, **options)
          server = ::Tiger::Server.new(app)

          server.run
        end
      end
    end

    register :tiger, Tiger
  end
end

