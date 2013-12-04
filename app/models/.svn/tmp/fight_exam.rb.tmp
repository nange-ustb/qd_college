# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: fight_exams
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  correct       :integer
#  incorrect     :integer
#  gold_count    :integer
#  current_stage :integer
#  stage_order   :text
#  status        :string(255)      default("new")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: fight_exams
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  gold_count    :integer          default(0)
#  current_stage :integer          default(1)
#  stage_order   :text
#  status        :string(255)      default("new")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: fight_exams
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  gold_count    :integer          default(0)
#  success_stage :integer          default(0)
#  current_stage :integer          default(1)
#  stage_order   :text
#  status        :string(255)      default("new")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class FightExam < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming

  include AASM

  enumerize :status, in:[:new, :started, :paused, :success, :failure], default: :new, :scope => true
  attr_accessible :user_id, :gold_count, :current_stage, :stage_order, :status
  #serialize :stage_order

  belongs_to :user
  has_many :fight_papers, :dependent => :destroy
  has_many :ranking_list_weeks, :class_name => "RankingListWeek"

  scope :finished, where(:status => ["success", "failure", "paused"])

  scope :search, lambda{ |params|
    where{
      conds = []
      conds << ( ( created_at >= params[:created_at] ) & ( created_at <= (params[:created_at].to_date + 1) ) ) if params[:created_at].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }
  }

  aasm :column => :status  do
    state :new, :initial => true
    state :started
    state :paused
    state :success
    state :failure

    event :start, :after => :update_current_fight_paper do
      transitions :to => :started, :from => [:new, :paused]
    end

    event :pause, :after => :create_ranking_list_record do
      transitions :to => :paused, :from => :started
    end

    event :fail, :after => :create_ranking_list_record do
      transitions :to => :failure, :from => [:started, :paused, :new]
    end

    event :succeed, :after => :create_ranking_list_record do
      transitions :to => :success, :from => [:started]
    end
  end

  before_create :update_stage_order

  def update_stage_order
    self.stage_order = QuestionStand.pluck(:id).sample(Setting.fight_stage).join(',')
    #self.stage_order = QuestionStand.pluck(:id).sample(Setting.fight_stage)
    #self.success_stage = 2990
    #self.current_stage = 2991
  end

  def current_fight_paper
    fight_papers.find_or_create_by_stage(:stage => self.current_stage, :question_id => (self.stage_order.split(',') || [])[self.current_stage - 1])
  end

  def update_current_fight_paper
    cfp = current_fight_paper
    cfp.created_at = Time.now
    cfp.save!
  end

  def create_ranking_list_record
    rlw = self.user.ranking_list_weeks.find_or_create_by_stage(:stage => RankingListWeek.current_week)
    current_week_gold_count = self.fight_papers.where{ (result == "right") & (created_at >= RankingListWeek.current_week_start ) & (created_at <= RankingListWeek.current_week_end) }.count * 100
    if rlw.gold_count.to_i < current_week_gold_count
      rlw.gold_count = current_week_gold_count
      rlw.fight_exam_id = self.id
      rlw.save!
      self.user.week_scored(current_week_gold_count)
    end

    current_gold_count = self.fight_papers.where{ (result == "right") }.count * 100
    rly = self.user.ranking_list_year
    if rly.gold_count.to_i < current_gold_count
      rly.gold_count = current_gold_count
      rly.fight_exam_id = self.id
      rly.save!
      self.user.scored(rly.gold_count)
    end
  end


  def self.expire_expired_fight_exams
    FightPaper.where{ created_at < 2.minutes.ago and result == 'none' }.each do |fp|
      fe = fp.fight_exam
      if fe.present? and fe.started?
        fp.result = "timeout"
        fe.status = "failure"
        fp.save
        fe.save
      end
    end
  end
end
