# -*- encoding : utf-8 -*-
class Admin::GamesController < Admin::ResourceController
  helper_method :attributes
  def create
    object = build_resource
    object.code = SecureRandom.hex(8)
    if create_resource(object)
      redirect_to  edit_resource_path(resource)
    else
      render :new
    end
  end

  def update
    update! do |success, failure|
      success.html {
        redirect_to edit_resource_path(resource)
      }
    end
  end

  private
	def attributes
    %w(level title)
	end 	
end
