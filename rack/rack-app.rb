require File.expand_path('../helpers/tag_helpers',__FILE__)
require 'tilt'

class RackApp
  include TagHelpers
  include Tilt::CompileSite
  
  Index = Tilt.new('views/index.haml')
  Layout = Tilt.new('views/layout.haml')

  def call(env)
    session(env)[:user_id] = 10
    request = Rack::Request.new(env)
    case request.path
      when '/'
        index_html = Index.render(self)
        layout_html = Layout.render(self) { index_html }
        Rack::Response.new(layout_html).finish
      when '/about'
        Rack::Response.new("Hello World").finish
    end
  end

  private

    def session(env)
      @session ||= env['rack.session']
    end
end
