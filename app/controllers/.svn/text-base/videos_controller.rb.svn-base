# -*- encoding : utf-8 -*-
class VideosController < ApplicationController
  def show
  	@video= Video.find_by_id params[:id]
  	if @video.type!= "Video"  or @video.blank?
  		render :text=> "对不起，您想查看的视频专题不存在" and return
  	end 
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

end
