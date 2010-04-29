class SinatraApp < Sinatra::Base
  require 'helpers/tag_helpers'
  include SinatraApp::Helpers

  configure do
    enable :sessions
  end

  before do
    session[:user_id] = 10
  end

  disable :logging
  disable :static
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
