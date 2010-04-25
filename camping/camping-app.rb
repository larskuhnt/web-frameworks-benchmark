require 'camping'

Camping.goes :CampingApp

module CampingApp::Controllers
  class Index
    def get
      "Im a camping application"
    end
  end
end
