require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    'Hello Tiger with Sinatra!'
  end

  get '/ping' do
    'pong'
  end
end
