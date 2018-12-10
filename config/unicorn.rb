ROOT = '/health_unit_api'.freeze

working_directory ROOT
preload_app true
pid "#{ROOT}/tmp/pids/unicorn_freights_api.pid"

logger Logger.new(STDOUT)

listen 80
worker_processes 2
timeout 60

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(ROOT, 'Gemfile')
end

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  # defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end
