svn up && bundle install && rake db:migrate  &&  nohup bundle exec sidekiq -C config/sidekiq.yml &

