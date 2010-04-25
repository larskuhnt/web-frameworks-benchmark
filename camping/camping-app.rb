require 'camping'
require 'camping/template'

Camping.goes :CampingApp

module CampingApp::Controllers
  class Index
    def get
      @headers['Content-Type'] = 'text/html'
      render :index
    end
  end
end