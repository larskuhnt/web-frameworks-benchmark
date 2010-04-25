require 'helpers/tag_helpers'

class RackApp
  include TagHelpers

  def call(env)
    session(env)[:user_id] = 10
    request = Rack::Request.new(env)
    case request.path
      when '/'
        index_html = Tilt.new('views/index.haml').render(self)
        layout_html = Tilt.new('views/layout.haml').render(self) { index_html }
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
