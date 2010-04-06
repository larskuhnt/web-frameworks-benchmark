# This file goes in domain.com/config.ru
require 'rubygems'
require 'sinatra'
require 'sinatra-app'

set :env,  :production
disable :run

run SinatraApp