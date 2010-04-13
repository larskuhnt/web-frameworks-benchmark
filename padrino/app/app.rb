class PadrinoApp < Padrino::Application  
  configure do
    enable :sessions
  end

  before do
    session[:user_id] = 10
  end
  
  get :index do
    render "index"
  end
  
  get :about do
    'Hello World!'
  end
end