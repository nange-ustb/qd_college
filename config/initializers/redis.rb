# -*- encoding : utf-8 -*-
require "redis"
require "redis-namespace"
require "redis/objects"

redis = Redis.new(:host => Setting.redis_host, :port => Setting.redis_port)
$redis = Redis::Objects.redis = Redis::Namespace.new("qd_college", :redis => redis)


sidekiq_url = "redis://#{Setting.redis_host}:#{Setting.redis_port}/12"
Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'qd_college_sidekiq', :url => sidekiq_url }
end
Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'qd_college_sidekiq', :url => sidekiq_url }
end
