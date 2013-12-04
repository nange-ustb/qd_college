svn up && bundle install --without test development && rake db:migrate RAILS_ENV=production && rake assets:precompile RAILS_ENV=production && touch tmp-restart.txt &&  nohup bundle exec sidekiq -C config/sidekiq.yml  -e production &

