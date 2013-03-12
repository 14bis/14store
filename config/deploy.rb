
set :application, "14store"
set :repository,  "git@github.com:14bis/14store.git"
set :ssh_options, {:forward_agent => true}

set :user, "ec2-user"

set :deploy_to, "/var/www/html/apps/#{application}"

set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :location, "ec2-54-225-228-173.compute-1.amazonaws.com"
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
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  # desc "Installs required gems"  
  # task :gems, :roles => :app do  
  #   run "cd #{current_path} && bundle install --without development test"  
  # end  
  # after "deploy:setup", "deploy:gems"  
end

task :symlink_database_yml do
  run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"
end
after "bundle:install", "symlink_database_yml"