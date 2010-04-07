#!/usr/bin/env ruby

#
# Runners
#

module Frameworks

  module Ramaze
    @port = 4000
    @path = "ramaze"

    def start
      execute "thin start -p #{port} -d -e production"
    end
    def stop
      execute "thin stop -f"
    end
  end

  module Rails
    @port = 4100
    @path = "rails"

    def start
      execute "thin start -p #{port} -d -e production"
    end
    def stop
      execute "thin stop -f"
    end
  end

  module Sinatra
    @port = 4200
    @path = 'sinatra'

    def start
      execute "thin start -p #{port} -d -e production"
    end
    def stop
      execute "thin stop -f"
    end
  end

  module Merb
    @port = 4300
    @path = 'merb'

    def start
      execute "thin start -p #{port} -d -e production"
    end
    def stop
      execute "thin stop -f"
    end
  end

  module Padrino
    @port = 4400
    @path = 'padrino'

    def start
      execute "thin start -p #{port} -d -e production"
    end
    def stop
      execute "thin stop -f"
    end
  end
end

module Runner
  module ClassMethods
    attr_accessor :port, :path
  end
  class Base
    attr_accessor :port, :path
    def self.new_with(mod)
      i = Class.new(self){ include mod }.new
      i.extend(InstanceMethods)
      mod.extend(ClassMethods)
      i.path = mod.path
      i.port = mod.port
      i
    end
    def execute(str)
      str = "cd #{path}; #{str}"
      puts ">> #{str}"
      system(str)
    end
  end
  module InstanceMethods
    def start
      puts "Starting #{path} on port #{port}"
      super
    end
    def stop
      puts "Stopping #{path} on port #{port}"
      sleep 0.3
      super
    end
  end
end

requests_num = (ENV['N'] || 1000).to_i
concurrency  = (ENV['C'] || 10).to_i

#
# Benchmark suite
#
runners = Frameworks.constants.map{|c| Frameworks.const_get(c)}
# runners = [Frameworks::Padrino, Frameworks::Sinatra]
runners.map{|r| r.extend(Runner::ClassMethods) }

def run(runners, requests_num, concurrency)
  # Small slow down to be sure that everythings was booted
  60.downto(0) { |i| print "Test start in #{i}s \r"; $stdout.flush; sleep 1 }
  puts "Testing frameworks with #{requests_num} requests and #{concurrency} connections: "
  runners.each do |r|
    puts "  #{r.name} on port #{r.port}"
  end

  results = runners.inject({}) do |table, r|
    instance = Runner::Base.new_with(r)
    port = r.port
    name = r.name.gsub(/^.*::/,'')
    puts "Benchmarking #{name} on port #{port}..."
    cmd = %{ab -c #{concurrency} -n #{requests_num} http://127.0.0.1:#{port}/ 2>/dev/null}
    puts ">> #{cmd}"
    result = `#{cmd}`
    sleep 0.3
    result[/Requests per second:\s*([\d.]+)/]
    rps = $1.to_f
    table[name] = rps
    table
  end

  results = results.to_a.sort_by{|a| a[1]}.reverse
  results.each do |(name, rps)|
    puts "  #{name} => #{rps} rps"
  end
end

def start(runners)
  runners.each do |r|
    instance = Runner::Base.new_with(r)
    instance.start
  end
end

def stop(runners)
  runners.each do |r|
    instance = Runner::Base.new_with(r)
    instance.stop
  end
end

cmd = ARGV[0]

if cmd == 'start'
  start(runners)
  puts ""
  puts ""
  sleep 0.5
  run(runners, requests_num, concurrency)
elsif cmd == 'restart'
  stop(runners)
  sleep 1
  start(runners)
  puts ""
  puts ""
  sleep 2
  run(runners, requests_num, concurrency)
elsif cmd == 'run'
  run(runners, requests_num, concurrency)
elsif cmd == 'stop'
  stop(runners)
else
  puts "Start and stop servers with ./benchmark.rb start|stop"
  puts "Use './benchmark.rb run' against already booted servers."
  puts ""
end