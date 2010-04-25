require 'camping'
Camping.goes :CampingApp
require 'views/main'

module CampingApp::Controllers
  class Index
    def get
      @headers['Content-Type'] = 'text/html'
      render :index
    end
  end
end