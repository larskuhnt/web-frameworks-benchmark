class RackApp
  def call(env)
    index_html = Tilt.new('views/index.erb').render
    Rack::Response.new(index_html).finish
  end
end