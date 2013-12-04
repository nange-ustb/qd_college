# -*- encoding : utf-8 -*-
class GamesController < ApplicationController
  def index
      respond_to do|f|
        f.html do
          @zones = Zone.provinces.collect {|z| [ z.name, z.id ] }
          @awards_hash = {}
          AwardRecord.level.values.each do |level|
            @awards_hash[level] = AwardRecord.with_level(level).order("created_at desc").includes(:user=>:zone).page(1).per(10)
          end
        end

        f.js do 
          @awards = AwardRecord.search(params[:search] || {:level=>params[:level]}).page(params[:page]).per(10)
        end
      end
  end

  def new
  	if game_chance = current_user.student.game_chances.unused.first
       game_chance.update_attribute(:used,true)
  		if award = game_chance.game.try(:play!)
        @award_record = current_user.award_records.create(:title=>award.title,:code=>award.code,:game_chance_id=>game_chance.id,
          :level=>game_chance.level,:username=>current_user.username,:zone_id=>current_user.zone_id,:zone_name=>current_user.zone_name,
          :affiliate_id=>current_user.try(:zone).try(:affiliate_id))
      else
        flash[:notice_info] = '对不起，您没有抽中！，不要灰心，下次再来'
      end
  	else
  		flash[:notice_info] = '对不起,您现在不能抽奖'
  	end
  end
end
