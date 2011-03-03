require 'rubygems'
require 'rack'
require File.expand_path('../rack-app',__FILE__)
require 'tilt'

app = Rack::Builder.new {
  use Rack::Session::Cookie
  use Rack::Static, :urls => ["/stylesheets"], :root => "public"
  run RackApp.new
}

run app
