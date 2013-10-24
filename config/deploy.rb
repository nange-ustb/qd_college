# -*- encoding : utf-8 -*-
  # cap deploy:staging_server need_bundle=1 need_migration=1 need_precompile_assets=1
require "rubygems"
gem "activesupport"
require "active_support/core_ext"
$application_name = "qd_college"

set :application, $application_name
$files_and_dirs = %w( app config Gemfile public lib Rakefile db script spec vendor Capfile config.ru )

set :scm , :none

role :staging_server, "118.145.26.152:10243" ,
     :ssh_options => { :username => "root" }

role :code_tmp_server, "118.145.26.152:10243" ,
     :ssh_options => { :username => "root" }

role :production_server, "192.168.10.177" ,
     :ssh_options => { :username => "root" }

$staging_code_path = "/opt/projects/#{$application_name}_codes/copy_#{Time.current.strftime("%Y%m%d%s")}"
$staging_app_tmp_path = "/usr/local/#{$application_name}_tmp"
$staging_app_log_path = "/usr/local/#{$application_name}_log"
$staging_app_public_path = "/usr/local/#{$application_name}_public"
$staging_app_lns = "/opt/projects/#{$application_name}"
$staging_carrierwave_path = "/opt/uploads/#{$application_name}/staging"
$staging_bundle = "/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle"
$staging_rake = "/opt/ruby-enterprise-1.8.7-2012.02/bin/rake"
$staging_when_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/whenever"
$staging_god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god"

$code_tmp_code_path = "/opt/projects/#{$application_name}_code_tmp_codes/copy_#{Time.current.strftime("%Y%m%d%s")}"
$code_tmp_app_lns = "/opt/projects/#{$application_name}_code_tmp"


$production_code_path = "/opt/projects/#{$application_name}_codes/copy_#{Time.current.strftime("%Y%m%d%s")}"
$production_app_tmp_path = "/usr/local/#{$application_name}_tmp"
$production_app_log_path = "/usr/local/#{$application_name}_log"
$production_app_public_path = "/usr/local/#{$application_name}_public"
$production_app_lns = "/opt/projects/#{$application_name}"
$production_carrierwave_path = "/opt/uploads/#{$application_name}/production"
$production_bundle = "/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle"
$production_rake = "/opt/ruby-enterprise-1.8.7-2012.02/bin/rake"
$production_when_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/whenever"
$production_god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god"


def god_is_running( app_path, bundle_path="/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle" , god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god"  )
  !capture("#{god_command( app_path , bundle_path , god_path )} status >/dev/null 2>/dev/null || echo 'not running'").start_with?('not running')
end

def god_command( app_path , bundle_path="/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle" , god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god" )
  "cd #{ app_path }; #{bundle_path} exec #{god_path}"
end

def terminate_if_running( app_path  , bundle_path="/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle" , god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god")
  if god_is_running(app_path , bundle_path , god_path)
    run "#{god_command( app_path , bundle_path , god_path )} terminate"
  end
end

def start_god(app_path , bundle_path="/opt/ruby-enterprise-1.8.7-2012.02/bin/bundle" , god_path = "/opt/ruby-enterprise-1.8.7-2012.02/bin/god")
  config_file = "#{app_path}/config/resque.god"
  environment = { :RAILS_ENV => rails_env, :RAILS_ROOT => app_path }
  run "#{god_command(app_path , bundle_path , god_path)} -c #{config_file}", :env => environment
end

namespace :deploy do

  task :staging_server ,:roles => :staging_server  do
    upload_file_and_init( $staging_code_path, $staging_app_log_path, $staging_app_tmp_path, $staging_app_lns, $staging_bundle, $staging_rake, $staging_carrierwave_path , $staging_when_path , $staging_god_path , "staging")
  end
  
  task :code_tmp_server ,:roles => :code_tmp_server  do
    run "mkdir -p #{$code_tmp_code_path}"
    $files_and_dirs.each do|fd|
      top.upload fd , "#{$code_tmp_code_path}/#{fd}" , :mode => "a+" if File.directory? fd or File.exists? fd
    end
    run "ln -nfs #{$code_tmp_code_path} #{$code_tmp_app_lns}"
  end
  
  task :production_server ,:roles => :production_server  do
    upload_file_and_init( $production_code_path, $production_app_log_path, $production_app_tmp_path, $production_app_lns, $production_bundle, $production_rake, $production_carrierwave_path , $production_when_path , $production_god_path , "production")
  end
  
  def self.upload_file_and_init( code_path, log_path, tmp_path, lns_path, bundle_path, rake_path, carrierwave_path, when_path , god_path , type)
    run "mkdir -p #{tmp_path}"
    run "mkdir -p #{log_path}"
    run "mkdir -p #{code_path}"
    run "mkdir -p #{carrierwave_path}"
    
    $files_and_dirs.each do|fd|
      top.upload fd , "#{code_path}/#{fd}" , :mode => "a+" if File.directory? fd or File.exists? fd
    end
    
    run "ln -nfs #{code_path} #{lns_path}"
    run "ln -nfs #{log_path}  #{lns_path}/log"
    run "ln -nfs #{tmp_path}  #{lns_path}/tmp"
    
    
    run "chmod 777 #{code_path}"
    run "chmod 777 #{log_path}"
    run "chmod 777 #{tmp_path}"
    run "chmod 777 #{lns_path}/public"
    run "chmod 777 #{carrierwave_path}"
    
    
    run "ln -nfs #{carrierwave_path}  #{lns_path}/public/uploads_#{type}"
    
    terminate_if_running( lns_path , bundle_path , god_path )
    run "cd #{lns_path} && #{bundle_path} install --without test development"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} db:migrate RAILS_ENV=#{type}"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} db:seed RAILS_ENV=#{type}"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} assets:update_geo_locations_selector RAILS_ENV=#{type}"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} assets:clean RAILS_ENV=#{type}"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} assets:precompile RAILS_ENV=#{type}"
    run "cd #{lns_path} && #{bundle_path} exec #{rake_path} environment resque:work RAILS_ENV=#{type} PIDFILE=#{tmp_path}/resque.pid BACKGROUND=yes QUEUE=gshop_mailer"
#    run "cd #{lns_path} && #{bundle_path} exec #{when_path} --update-crontab RAILS_ENV=#{type}"
    run "cd #{lns_path} && touch tmp/restart.txt"
    start_god(lns_path , bundle_path , god_path)
  end
end
