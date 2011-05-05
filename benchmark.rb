@path         = File.expand_path(File.dirname(__FILE__))
@requests     = (ENV['N'] || 1000).to_i
@concurrency  = (ENV['C'] || 10).to_i
@frameworks   = %w(camping merb padrino rack rails ramaze sinatra)

def run
  puts "Testing frameworks with #{@requests} requests and #{@concurrency} connections: "

  results = {}

  @frameworks.sort.each_with_index do |f, i|
    port = 4000+i*10
    puts "Benchmarking #{f} on port #{port}..."
    cmd  = "ab -c #{@concurrency} -n #{@requests} http://127.0.0.1:#{port}/ 2>/dev/null"
    puts "=> #{cmd}"
    result = `#{cmd}`
    sleep 2
    result =~ /Requests per second:\s*([\d.]+)/
    results[f] = $1.to_f
  end

  puts "=" * 40
  puts sys_info
  puts "=" * 40
  puts "Using:"
  puts gems_info
  puts "=" * 40
  puts "Results:"

  results.to_a.sort_by { |a| a[1] }.reverse.each do |name, rps|
    puts "  #{name} => #{rps} rps"
  end
end

def start
  @frameworks.sort.each_with_index do |f, i|
    cmd  = "thin start -d -p #{4000+i*10} -e production -c #{File.join(@path, f)}"
    puts "=> #{cmd}"
    system cmd
  end
  puts "Test will start in 20 seconds... please wait..."
  sleep 20
end

def stop
  @frameworks.each do |f|
    cmd = "thin stop -e production -c #{File.join(@path, f)}"
    puts "=> #{cmd}"
    system cmd
  end
end

def gems_info
  logs = Dir["**/Gemfile.lock"].map { |f| File.read(f) }.join("\n")
  "  " + logs.scan(/((?:#{@frameworks.join("|")}){1} \([\d\.]+\))/i).flatten.uniq.join("\n  ")
end

def sys_info
  uname    = `uname -sr`.chomp
  sys_info = uname =~ /darwin/i ? `system_profiler` : `cat /proc/cpuinfo` + `cat /proc/meminfo`
  sys_info =~ /(?:Memory|MemTotal):\s+(.*)/
  mem      = $1
  sys_info =~ /(?:Processor Name|model name):\s+(.*)/
  cpu_name = $1
  sys_info =~ /(?:Processor Speed|cpu MHz):\s+(.*)/
  cpu_mhz  = $1
  (<<-TXT).gsub(/^ {4}/, '')
    System: #{uname}
    Processor: #{cpu_name} #{cpu_mhz}
    Memory: #{mem}
    Ruby: #{RUBY_DESCRIPTION}
  TXT
end

def setup
  Dir["**/*.log"].each { |f| `rm -rf #{f}` }
  Dir["**/Gemfile"].each do |file|
    puts "=> Updating #{file}"
    `cd #{File.dirname(file)}; rm -rf Gemfile.lock; bundle install`
  end
end

case (ARGV[0] || :help).to_sym
  when :run
    run
  when :start
    start
    run
  when :stop
    stop
  when :restart
    stop
    start
    run
  when :setup
    setup
  else
    help = (<<-TXT).gsub(/^ {6}/, '')
      Start and stop servers with:
        $ ruby ./benchmark.rb start|stop|restart|run"

      Install gems with:
        $ ruby ./benchmark.rb setup"
    TXT
    puts help
end