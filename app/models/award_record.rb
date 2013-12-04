# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: award_records
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  code           :string(255)
#  level          :string(255)
#  user_id        :integer
#  game_chance_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  username       :string(255)
#  affiliate_id   :integer
#  zone_id        :integer
#  zone_name      :string(255)
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: award_records
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  code           :string(255)
#  level          :string(255)
#  user_id        :integer
#  game_chance_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class AwardRecord < ActiveRecord::Base
  extend Enumerize
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner, :scope => true
  attr_accessible :game_chance_id, :code, :title, :user_id,:level,:username, :zone_id, :zone_name, :affiliate_id
  belongs_to :user
  delegate :name,:username,:mobile,:address,:company, to: :user, allow_nil:  true

  scope :search , lambda{|params|
    includes(:user).where{
      conds = []
      conds << ( level.eq params[:level] ) if params[:level].present?
      conds << ( zone_id.in Zone.of_citys(params[:province_id]).pluck(:code) ) if params[:province_id].present?
      conds << ( zone_id.eq params[:zone_id] ) if params[:zone_id].present?
      conds << ( username =~ "%#{params[:username]}%" ) if params[:username].present?
      conds << ( affiliate_id.eq params[:affiliate_id] ) if params[:affiliate_id].present?
      conds << ( created_at >= params[:start_at]) if params[:start_at].present?
      conds << ( created_at <= params[:end_at]) if params[:end_at].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.order("award_records.created_at desc")
  }
end


