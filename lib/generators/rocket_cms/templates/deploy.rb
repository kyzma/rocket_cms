set :user, "<%= app_name.downcase %>"
set :application, '<%= app_name.downcase %>'
set :scm, :git
set :repo_url, 'git@github.com:rs-pro/<%= app_name.downcase %>.git'

set :branch, ENV["REVISION"] || "master"

set :deploy_to, "<%= deploy_to %>

# require 'hipchat/capistrano'
# set :hipchat_token, ""
# set :hipchat_room_name, "#{app_name}"
# set :hipchat_announce, false

set :rvm_type, :user
set :rvm_ruby_version, "2.1.2@#{fetch :application}"
set :use_sudo, false

set :keep_releases, 20

set :linked_files, %w{config/mongoid.yml config/secrets.yml}
set :linked_dirs, %w{log tmp vendor/bundle public/assets public/system public/uploads public/ckeditor_assets public/sitemap}

namespace :db do
  desc "Create the indexes defined on your mongoid models"
  task :create_mongoid_indexes do
    on roles(:app) do
      execute :rake, "db:mongoid:create_indexes"
    end
  end
end

namespace :deploy do
  task :restart do
  end
  desc "Update the crontab"
  task :update_crontab do
    on roles(:app) do
      execute "cd #{release_path}; #{fetch(:tmp_dir)}/#{fetch :application}/rvm-auto.sh . bundle exec whenever --update-crontab #{fetch :user} --set \'environment=#{fetch :stage}&current_path=#{release_path}\'; true"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'unicorn:duplicate' 
#before "deploy:update_crontab", 'rvm1:hook'
#after "deploy:restart", "deploy:update_crontab"
