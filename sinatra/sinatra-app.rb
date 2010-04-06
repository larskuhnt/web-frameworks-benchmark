class SinatraApp < Sinatra::Application
  get '/' do
    %{Hi, I'm a small Sinatra application!}
  end
end