require 'rubygems'
require 'rack'
require 'rack-app'
require 'tilt'

app = Rack::Builder.new {
  use Rack::Session::Cookie
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"
  run RackApp.new
}

run app