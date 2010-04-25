require 'camping'
require 'camping/session'
Camping.goes :CampingApp
require 'views/main'

module CampingApp
  include Camping::Session
  secret "This is a test"
  
  def service(*args)
    @state[:user_id] = 10
    super(*args)
  end
end

module CampingApp::Controllers
  class Index
    def get
      @headers['Content-Type'] = 'text/html'
      render :index
    end
  end
  
  class About
    def get
      'Hello World!'
    end
  end
  
  class Stylesheet < R '/stylesheets/application.css'
    def get
      @headers['Content-Type'] = 'text/css'
      File.read(File.dirname(__FILE__) + '/public/stylesheets/application.css')
    end
  end
end
