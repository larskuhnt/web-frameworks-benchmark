class PadrinoApp < Padrino::Application
  register Padrino::Helpers
  enable  :sessions
  disable :logging
  disable :static
  disable :method_override
  disable :show_exceptions
end