require 'tilt'

class RackApp
  include Tilt::CompileSite
  
  Index = Tilt.new('views/index.erb')
  
  def call(env)
    index_html = Index.render(self)
    Rack::Response.new(index_html).finish
  end
end