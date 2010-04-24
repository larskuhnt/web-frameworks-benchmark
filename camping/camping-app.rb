require 'camping'

Camping.goes :App

module App::Controllers
  class Index
    def get
      "Im a camping application"
    end
  end
end
