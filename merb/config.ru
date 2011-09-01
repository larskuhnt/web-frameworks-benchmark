begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

require 'merb-core'

Merb::Config.setup(
  :merb_root   => File.expand_path(File.dirname(__FILE__)),
  :environment => ENV['RACK_ENV']
)

Merb.environment = Merb::Config[:environment]
Merb.root        = Merb::Config[:merb_root]

Merb::BootLoader.run

# use Rack::Head to handle HEAD requests properly
use Rack::Head

# Correctly set a content length.
use Merb::Rack::ContentLength

# use PathPrefix Middleware if :path_prefix is set in Merb::Config
if prefix = ::Merb::Config[:path_prefix]
  use Merb::Rack::PathPrefix, prefix
end

# comment this out if you are running merb behind a load balancer
# that serves static files
use Merb::Rack::Static, Merb.dir_for(:public)

run Merb::Rack::Application.new
