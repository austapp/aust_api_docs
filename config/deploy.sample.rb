require "bundler/capistrano"

set :application, "aust_api_docs"
set :repository,  "git@github.com:austapp/aust_api_docs.git"

set :scm, :git
set :user, "deploy"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"

role :web, "WEBSERVER"
default_run_options[:pty] = true

set :default_environment, {
  'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH'
}

after "deploy", "deploy:build"

namespace :deploy do
  task :build, :roles => :web do
    run "cd #{current_path} && bundle install && rake build"
  end
end
