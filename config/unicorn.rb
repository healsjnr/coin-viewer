@base_dir = "#{File.expand_path(File.dirname(__FILE__))}/.."

worker_processes 1
working_directory @base_dir
timeout 30
puts "Rack env: #{ENV['RACK_ENV']}"

runon = 8080 
puts "Running using: #{runon} and rack env: #{ENV['RACK_ENV']}"
# Tell unicorn the socket to use. This will be used by NGINX
listen runon, :backlog => 64

# Set PID file
pid "#{@base_dir}/tmp/pids/unicorn.pid"

# Set log output fiels
stderr_path "#{@base_dir}/log/unicorn.err.log"
stdout_path "#{@base_dir}/log/unicorn.out.log"
