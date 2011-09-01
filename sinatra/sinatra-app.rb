class SinatraApp < Sinatra::Base
  require File.expand_path('../helpers/tag_helpers',__FILE__)
  include SinatraApp::Helpers

  enable :sessions
  set :public, File.expand_path('../public', __FILE__)

  before do
    session[:user_id] = 10
  end

  disable :logging
  disable :method_override
  disable :show_exceptions

  get '/' do
    content_type 'text/html'
    haml :index
  end

  get '/about' do
    'Hello World!'
  end
end
