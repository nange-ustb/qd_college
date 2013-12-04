# -*- encoding : utf-8 -*-
class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user_level,:only=>[:show]
  def show
  	@video= Video.find_by_id params[:id]
  	if @video.type!= "Video"  or @video.blank?
  		render :text=> "对不起，您想查看的视频专题不存在" and return
  	end 
   @video.increment!(:view_count,1)
  	@video_nodes= @video.video_nodes.order_position.page(params[:page]).per(5)
  end

  def index 
	  	unless request.xhr?
	  		redirect_to :back and return 
	  	end 
	  	@video= Video.find_by_id params[:id]
	  	@video_nodes= @video.video_nodes.order_position.page(params[:page]).per(5)

  end 

  def broadcast
  		@video_node= VideoNode.find_by_id params[:id]	
  end 

  private 
    def check_user_level
      @document= Document.find_by_id params[:id]
      user_level= current_user.try(:student).try(:level) 
      able= case user_level
      when "mediate"
        ['mediate'].include? @document.try(:level)
      when "advanced"
        ['mediate', 'advanced'].include? @document.try(:level)
      else
        false
      end 

      unless able
        flash[:notice] = "您当前的级别不可以操作视频!"
        redirect_to(root_path)  and return
      end
    end

end
