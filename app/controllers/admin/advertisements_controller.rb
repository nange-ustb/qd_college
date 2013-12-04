# -*- encoding : utf-8 -*-
class Admin::AdvertisementsController < Admin::ResourceController
	helper_method :attributes
	private 
	def attributes
		["image_url", "title", "link_url"]
	end 
end
