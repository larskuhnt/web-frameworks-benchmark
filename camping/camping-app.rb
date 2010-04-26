require 'camping'
require 'camping/session'

require 'camping/template'
require 'haml'

Camping.goes :CampingApp

module CampingApp
  set :secret, "This is a test"
  set :views, File.dirname(__FILE__) + '/views'
  
  include Camping::Session

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
    CONTENT = File.read(File.dirname(__FILE__) + '/public/stylesheets/application.css')
    
    def get
      @headers['Content-Type'] = 'text/css'
      CONTENT
    end
  end
end

module CampingApp::Helpers
  def stylesheet_link_tag(source)
    %Q{<link type="text/css" media="screen" rel="stylesheet" href="/stylesheets/#{source}.css?1271182870" />}
  end
  
  def link_to(caption, url)
    %Q{<a href="#{url}">#{caption}</a>}
  end
end
