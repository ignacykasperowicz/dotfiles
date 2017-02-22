lock '3.7.1'

SSHKit.config.output_verbosity = Logger::DEBUG

set :application, 'durst_portal'
set :repo_url, 'git@github.com:thedurstorganization/durst_portal.git'
set :branch, ENV['BRANCH'] || 'master'
set :deploy_to, "/var/projects/durst/#{fetch(:application)}"
set :scm, :git

set :deploy_via, :remote_cache
set :stages, %w(staging production)
set :default_stage, 'staging'
set :local_user, ENV['LOCAL_USER'] || -> { Etc.getlogin }
set :user, 'ubuntu'
set :keep_releases, 5

set :rvm_type, :user
set :rvm_ruby_version, "#{`cat .ruby-version`.chomp}@#{`cat .ruby-gemset`.chomp}"

set :linked_files, [
  'config/database.yml',
  'config/durst_api.yml',
  'config/secrets.yml',
  'config/smtp.yml',
  'config/aws.yml',
  'config/markdown.yml',
  'config/anonymizer.yml',
  'config/carrierwave.yml',
  'config/nestio.yml',
  'config/appointments.yml',
  'config/analytics.yml',
  'config/on_site.yml',
  'config/twilio.yml',
  'config/basic_auth.yml',
  'config/airbrake.yml',
  'config/concessions.yml',
]

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)

# capistrano-db-tasks
set :db_local_clean, true
set :db_remote_clean, true
set :assets_dir, %w(public/uploads)
set :local_assets_dir, 'public'
set :compressor, :bzip2

# capistrano-passenger
set :passenger_restart_with_touch, true

# Capistrano-clockwork
set :clockwork_file, 'config/clock.rb'

after 'deploy:finished', 'deploy:sitemap:refresh'

# Airbrake after deploying
after 'deploy:finished', 'airbrake:deploy'
