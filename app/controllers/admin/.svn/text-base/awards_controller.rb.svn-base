# -*- encoding : utf-8 -*-
class Admin::AwardsController < Admin::ResourceController
  before_filter :find_game,:only=>[:index]
  helper_method :attributes

  def index
    @awards = @game.awards.page(params[:page])
  end

  def new
    new!{resource.game_id = params[:game_id]}
  end

  def create
    create! do |success, failure|
      success.html {
        redirect_to collection_path(:game_id=>resource.game_id)
      }
    end
  end

  def update
    update! do |success, failure|
      success.html {
        redirect_to collection_path(:game_id=>resource.game_id)
      }
    end
  end

	private
	def attributes
  		[:title,:probability, :count] 
  end 	

  def find_game
    @game = Game.find(params[:game_id])
  end
end
