# -*- encoding : utf-8 -*-
class Admin::VideoNodesController < Admin::ResourceController
  before_filter :find_video,:only=>[:index]
  def index
    @videos = @video.video_nodes.page(params[:page])
  end

  def create
    object = build_resource
    if create_resource(object)
      redirect_to  collection_path(:video_id=>resource.video_id)
    else
      render :new
    end
  end

  def update
    update! do |success, failure|
      success.html {redirect_to resource_path(resource,:video_id=>resource.video_id)}
    end
  end

  private
  def find_video
    @video = Video.find(params[:video_id])
  end
end
