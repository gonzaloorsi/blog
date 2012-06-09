require "bundler/capistrano"


load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
#load "config/recipes/nodejs"
#load "config/recipes/rbenv"
#load "config/recipes/check"



server "106.187.97.179", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "blog"
set :deploy_to, "/home/#{user}/apps/#{application}"
#set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_via, :copy

set :bundle_gemfile,  "Gemfile"
  set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
  set :bundle_flags,    "--deployment --quiet"
  set :bundle_without,  [:development, :test]
  set :bundle_cmd,      "bundle" # e.g. "/opt/ruby/bin/bundle"
  set :bundle_roles,    {:except => {:no_release => true}} # e.g. [:app, :batch]


set :scm, "git"
set :repository, "git@github.com:gonzaloorsi/#{application}.git"
set :branch, "master"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true




after "deploy", "deploy:cleanup" # keep only the last 5 releases


