source 'http://ruby.glodon.com'
source 'http://ruby.taobao.org'

if RUBY_VERSION =~ /1.9/

  Encoding.default_external = Encoding::UTF_8

  Encoding.default_internal = Encoding::UTF_8

end

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'therubyracer'
gem 'pg'


gem 'json'
gem "factory_girl" , "< 3.0"
gem 'factory_girl_rails',  :group => [:development, :test]

group :development do
  gem 'sqlite3'
  gem "capistrano"
  gem 'guard-livereload'
  gem 'quiet_assets'
  gem 'yajl-ruby'
  gem "better_errors"
  gem "thin"
  gem 'rspec-rails'
  gem 'annotate'
  gem "magic_encoding"
end

group :production , :staging do
  gem "pg"
end

group :test do  
  gem 'turn', :require => false
  gem "rspec"
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem "jquery-rails",  '2.1.4'
gem  "aasm"
gem  "carrierwave"
gem  "mini_magick"
gem  'inherited_resources'
gem  'simple_form'
gem  'haml-rails'
gem  'kaminari'
gem  'has_scope'
gem  'responders'
gem 'spreadsheet'
gem "uuid"
#gem "scoped_search"
gem 'jquery_datepicker'
gem "squeel"

gem 'faraday'
#gem 'system_timer'
gem 'paranoia'
# gem 'resque'
# gem 'resque_mailer'
# gem 'god'
# gem "friendly_id"
gem "twitter-bootstrap-rails" , "2.1.3"
gem 'rails_kindeditor'


#sso cas
gem 'rubycas-client'
gem 'devise' , "2.1.2"
gem 'devise_cas_authenticatable'
gem 'cancan'

#other
gem 'settingslogic'

# enumerize
gem 'enumerize'

gem 'acts_as_list', '= 0.2.0'
gem 'awesome_nested_set', '2.1.5'
gem 'nokogiri', "1.5.6"

#validate
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'random_record'
gem 'redis-objects'
gem 'redis-namespace'
gem 'active_decorator'
gem 'sidekiq'
