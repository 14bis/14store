# bundler/capistrano executes bundle:install
require "bundler/capistrano"

set :application, "14store"
set :repository,  "git@github.com:14bis/14store.git"

# If the repository is public and you do not have ssh agent forwarding
# configured on your local machine uncomment next line
# set :deploy_via, :copy
# If deploying via copy this line is unecessary
set :ssh_options, {:forward_agent => true}

set :user, "deployer"

set :deploy_to, "/home/deployer/webapps/#{application}"

set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :location, "ec2-23-20-254-38.compute-1.amazonaws.com"
role :web, location                          # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true # This is where Rails migrations will run
role :db,  location

default_run_options[:shell] = '/bin/bash --login'
default_environment["RAILS_ENV"] = 'production'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# use database.yml from server instead of the one public on github
task :symlink_database_yml do
  run "rm #{release_path}/config/database.yml"
  run "ln -sf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
after "bundle:install", "symlink_database_yml"

set :normalize_asset_timestamps, false
namespace :assets do
  desc "Precompile assets locally and then rsync to app servers"
  task :precompile, :only => { :primary => true } do
    # run_locally "mkdir -p public/assets;"
    run_locally "bundle exec rake assets:clean_expired; bundle exec rake assets:precompile;"
    servers = find_servers :roles => [:app], :except => { :no_release => true }
    servers.each do |server|
      run_locally "rsync -av ./public/assets/ #{user}@#{server}:#{current_path}/public/assets/;"
    end
    # run_locally "mv public/assets public/__assets"
  end
end
# After associate current_path 
after "deploy:create_symlink", "assets:precompile"

# web server tasks
namespace :unicorn do
  desc "Zero-downtime restart of Unicorn"
  task :restart, except: { no_release: true } do
    run "kill -s USR2 `cat /tmp/unicorn.14store.pid`"
  end
 
  desc "Start unicorn"
  task :start, except: { no_release: true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end
 
  desc "Stop unicorn"
  task :stop, except: { no_release: true } do
    run "kill -s QUIT `cat /tmp/unicorn.14store.pid`"
  end
end
after "deploy:restart", "unicorn:restart"

# Run migrations
after "deploy", "deploy:migrate"