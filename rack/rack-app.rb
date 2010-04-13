class RackApp
  def call(env)
    [200, {"Content-Type" => "text/html"}, "Im rack application"]
  end
end
