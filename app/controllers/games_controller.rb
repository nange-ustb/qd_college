# -*- encoding : utf-8 -*-
class GamesController < ApplicationController
  def index
      respond_to do|f|
        scope = current_user.award_records

        f.html do
          @awards_hash = {}
          AwardRecord.level.values.each do |level|
            @awards_hash[level] = scope.with_level(level).page(1)
          end
        end

        f.js do 
          @awards = scope.with_level(params[:level]).page(params[:page])
        end
      end
  end

  def new
  	if game_chance = current_user.student.game_chances.unused.first
       game_chance.update_attribute(:used,true)
  		if award = game_chance.game.try(:play!)
        @award_record = current_user.award_records.create(:title=>award.title,:code=>award.code,:game_chance_id=>game_chance.id,
          :level=>game_chance.level)
      else
        flash[:notice] = '对不起，您没有抽中！，不要灰心，下次再来'
      end
  	else
  		flash[:notice] = '对不起,您现在不能抽奖'
  	end
  end
end
