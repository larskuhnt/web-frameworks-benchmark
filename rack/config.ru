require 'rubygems'
require 'rack'
require File.expand_path('../rack-app',__FILE__)

run RackApp.new
