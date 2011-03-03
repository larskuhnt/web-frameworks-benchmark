# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development" unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.dirname(__FILE__) + '/..' unless defined? PADRINO_ROOT

# Load Bundler
require 'rubygems'
require 'bundler'
# Only have default and environemtn gems
Bundler.setup(:default, PADRINO_ENV.to_sym)
# Only require default and environment gems
Bundler.require(:default, PADRINO_ENV.to_sym)

puts "=> Located #{Padrino.bundle} Gemfile for #{Padrino.env}"

Padrino.load!
