require 'rack'
require '../lib/rack/handler/tiger'

app = Rack::Builder.new do
  run ->(env) do
    [200, {'content-type' => 'text/plain'}, ['Hello Tiger!']]
  end
end

run app
