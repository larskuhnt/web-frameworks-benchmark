class RackApp
  def call(env)
    [ 200, {"Content-Type" => "text/html"}, Tilt.new('views/index.erb').render ]
  end
end
