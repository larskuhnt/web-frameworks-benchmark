require 'rubygems'
require 'rack'
require File.expand_path('../rack-app',__FILE__)
require 'tilt'

run RackApp.new
