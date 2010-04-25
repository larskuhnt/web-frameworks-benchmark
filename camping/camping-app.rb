require 'camping'
Camping.goes :CampingApp
require 'views/index'

module CampingApp::Controllers
  class Index
    def get
      @headers['Content-Type'] = 'text/html'
      render :index
    end
  end
end