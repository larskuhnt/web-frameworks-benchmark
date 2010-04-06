class RackApp
  def call(env)
    [200, {"Content-Type" => "text/html"}, %{Hi, I'm a small rack application!}]
  end
end
