class PadrinoApp < Padrino::Application
  get :index do
    erb :index
  end
end