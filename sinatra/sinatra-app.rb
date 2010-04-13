class SinatraApp < Sinatra::Application
  get '/' do
    content_type 'text/html'
    "Im a sinatra application"
  end
end