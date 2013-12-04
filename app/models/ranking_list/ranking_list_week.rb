# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ranking_lists
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  fight_exam_id :integer
#  type          :string(255)
#  stage         :integer          default(0)
#  gold_count    :integer          default(0)
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ranking_lists
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  fight_exam_id :integer
#  type          :string(255)
#  stage         :integer          default(0)
#  gold_count    :integer          default(0)
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ranking_lists
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  fight_exam_id :integer
#  type          :string(255)
#  stage         :integer          default(0)
#  gold_count    :integer          default(0)
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class RankingListWeek < RankingList
  attr_accessible :user_id,:type,:stage,:gold_count,:position

  scope :current_week_records, lambda{ where(:stage => RankingListWeek.current_week) }

  def current_week_record
    self.current_week_records.first
  end

  def self.current_week
    RankingListWeek.current_week_no
  end

  def self.current_week_start
    Date.today.at_beginning_of_week
  end

  def self.current_week_end
    Date.today.at_end_of_week
  end

  def fight_times
    self.user.fight_exams.finished.where(" created_at >= ? and created_at <= ? ", Date.today.at_beginning_of_week, Date.today.at_end_of_week).count
  end

  #$redis.keys.grep(/high/).each{ |hs| $redis.del(hs) }
  def scored
    $redis.zadd("week_#{self.stage}_high_scores", self.gold_count, self.user.id)
  end

end
