class PadrinoApp < Padrino::Application
  disable :sessions
  disable :flash
  disable :logging
  disable :padrino_logging
  disable :static
  disable :method_override
  disable :show_exceptions

  get :index do
    "Im a padrino application"
  end
end
