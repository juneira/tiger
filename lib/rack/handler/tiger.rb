require_relative '../../tiger'

module Rackup
  module Handler
    module Tiger
      class << self
        def run(app, **options)
          server = ::Tiger::Server.new(app)

          server.run
        end
      end
    end

    register :tiger, Tiger
  end
end

