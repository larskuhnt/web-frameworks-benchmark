require 'rubygems'
require 'sinatra'
require 'sinatra-app'

set :env,  :production
disable :run

run SinatraApp