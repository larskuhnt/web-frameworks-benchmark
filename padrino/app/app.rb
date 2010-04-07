class PadrinoApp < Padrino::Application
  get :index do
    ##
    # This is pretty different than sinatra render because
    # look for templates and also application layout for
    # the given content_type and locale
    #
    render "index"
  end
end