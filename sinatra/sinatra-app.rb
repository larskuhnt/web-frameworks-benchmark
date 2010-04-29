class SinatraApp < Sinatra::Base
  set :env, :production

  disable :logging
  disable :static
  disable :method_override
  disable :show_exceptions

  get '/' do
    content_type 'text/html'
    "Im a sinatra application"
  end
end
