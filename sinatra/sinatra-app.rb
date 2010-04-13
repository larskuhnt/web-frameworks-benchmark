class SinatraApp < Sinatra::Application
  get '/' do
    content_type 'text/html'
    erb :index
  end
end