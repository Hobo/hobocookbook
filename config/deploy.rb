set :application, "cookbook"
set :domain,      "cookbook-staging.hobocentral.net"
# set :domain,      "li285-250.members.linode.com"
set :deploy_to,   "/home/cookbook20"
set :repository,  "git://github.com/Hobo/hobocookbook"
set :revision,    "origin/master"
set :skip_scm, false

set :user, "cookbook"
set :domain, "#{user}@cookbook.hobocentral.net"

set :bundle_cmd, "/opt/ruby-1.8.7-p334/bin/bundle"
set :rake_cmd, "PATH=/opt/ruby-1.8.7-p334/bin:$PATH #{bundle_cmd} exec rake"
# set :rake_cmd, "/usr/local/rvm/bin/cookbook_rake"

namespace :vlad do
  desc 'Restart Passenger'
  remote_task :start_app, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc 'reload api tags'
  remote_task :update_cookbook do
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:load_api_docs"
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:load_manual"
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:load_tutorials"
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} cookbook:load_blog"
  end

  desc 'update secret in config/environment.rb'
  remote_task :update_secret do
    secret=`dd if=/dev/urandom bs=64 count=1`.unpack("Q8").map {|i| i.to_s(16)}.join("")
    run "cd #{current_release}/config/initializers; sed -i.bak -e's/REPLACE_ME_WITH_A_REAL_SECRET/#{secret}/' secret_token.rb"
  end

  desc 'save version'
  remote_task :save_version do
    run "cd #{scm_path}/repo; git rev-parse HEAD > #{current_release}/git-version"
    run "echo #{scm_path}/repo > #{current_release}/git-path"
  end

  remote_task :copy_config_files, :roles => :app do
    run "ln -sf #{shared_path}/log #{current_release}/log"
    run "cp -r #{shared_path}/config/* #{current_release}/config/"
    run "ln -sf #{shared_path}/public/* #{current_release}/public/"
    run "rm -f #{current_release}/config.ru"  # passenger behaves better without a config.ru
  end

  desc 'bundle install --deployment --without development'
  remote_task :bundle_install do
    run " cd #{current_release}; RAILS_ENV=production #{bundle_cmd} install --deployment --without 'development test'"
  end

  desc 'precompile assets'
  remote_task :precompile_assets do
    run " cd #{current_release}; RAILS_ENV=production #{rake_cmd} assets:precompile"
  end

  desc 'remove log to work around vlad brokenness'
  remote_task :remove_log do
    run "rm -rf #{current_release}/log"
  end

  remote_task :finish_deployment, :roles => :app do
    Rake::Task["vlad:copy_config_files"].invoke
    Rake::Task["vlad:bundle_install"].invoke
    Rake::Task["vlad:precompile_assets"].invoke
    Rake::Task["vlad:save_version"].invoke
    Rake::Task["vlad:update_secret"].invoke
    Rake::Task["vlad:update_cookbook"].invoke
    Rake::Task["vlad:remove_log"].invoke
  end

  remote_task :update_symlinks => :finish_deployment
end
