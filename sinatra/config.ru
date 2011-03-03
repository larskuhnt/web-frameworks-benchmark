require 'rubygems'
require 'sinatra'
require File.expand_path('../sinatra-app',__FILE__)

set :env,  :production
disable :run

run SinatraApp
