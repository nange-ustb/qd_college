# -*- encoding : utf-8 -*-
class Users::FavoritesController < ApplicationController
  before_filter :authenticate_user!
#  skip_filter :init_top_banner,:detect_current_location , :only => [:destroy,:destroy_all]
  def index
    @favorites= current_user.favorites.page(params[:page]).per(10)
  end

  def destroy
    @favorite= Favorite.find params[:id]
    @favorite.destroy if @favorite.user_id == current_user.id
    redirect_to :back
  end

  def destroy_all
    @favorites= current_user.favorites.where(:id => params[:favorites].map(&:to_i) ).destroy_all  if params[:favorites]
    redirect_to :back
  end

end
