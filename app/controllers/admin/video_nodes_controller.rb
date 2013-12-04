# -*- encoding : utf-8 -*-
class Admin::VideoNodesController < Admin::ResourceController
  before_filter :find_video,:only=>[:index]
  def new
    new!{build_logo_association;resource.video_id = params[:video_id]}
  end

  def index
    @videos = @video.video_nodes.page(params[:page])
  end

  def create
    object = build_resource
    build_logo_association
    if create_resource(object)
      redirect_to  collection_path(:video_id=>resource.video_id)
    else
      resource.video_id = params[:video_node][:video_id]
      render :new
    end
  end

  def update
    update! do |success, failure|
      success.html {redirect_to resource_path(resource,:video_id=>resource.video_id)}
      failure.html {
        build_logo_association
        render :edit
      }
    end
  end

  private
  def build_logo_association
    resource.build_logo unless resource.logo
  end

  def find_video
    @video = Video.find(params[:video_id])
  end
end
