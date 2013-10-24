# -*- encoding : utf-8 -*-
class Admin::DocumentsController < Admin::ResourceController
  has_scope :search , :only => [:index] , :type => :hash
  has_scope :sti_in_document, :default => resource_class.to_s
  #authorize_resource
  # inherit_resources
  def new
  	new!{build_associations}
  end

  def create
    object = build_resource
    build_associations
    if create_resource(object)
      resource.ppt_2_swf
      redirect_to  resource_path(resource)
    else
      render :new
    end
  end

  def update
    update! do |success, failure|
      failure.html {
        build_associations
        render :edit
      }
    end
  end

  private
	def build_associations
	  resource.build_logo unless resource.logo
	  resource.build_file unless resource.file
	end
end
