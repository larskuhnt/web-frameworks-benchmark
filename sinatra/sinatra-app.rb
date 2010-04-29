class SinatraApp < Sinatra::Base
  set :env, :production

  disable :logging
  disable :static
  disable :method_override
  disable :show_exceptions

  get '/' do
    "Im a sinatra application"
  end
end
