class RackApp
  def call(env)
    Rack::Response.new("Im rack application").finish
  end
end