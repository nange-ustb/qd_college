# -*- encoding : utf-8 -*-
require "redis"
require "redis-namespace"
require "redis/objects"

redis = Redis.new(:host => "127.0.0.1",:port => "6379")
Redis::Objects.redis = Redis::Namespace.new("qd_college", :redis => redis)

sidekiq_url = "redis://127.0.0.1:6379/12"
Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'qd_college_sidekiq', :url => sidekiq_url }
end
Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'qd_college_sidekiq', :url => sidekiq_url }
end
