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
class RankingListYear < RankingList

  def fight_times
    self.user.fight_exams.finished.count
  end

  #$redis.keys.grep(/high/).each{ |hs| $redis.del(hs) }
  def scored
    $redis.zadd("high_scores", self.gold_count, self.user.id)
  end

end
