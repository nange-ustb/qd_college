# -*- encoding : utf-8 -*-
namespace :every_minute do
  desc "do_something_every_minute"
  task :do_something_every_minute => :environment do
    FightExam.expire_expired_fight_exams
  end
end


