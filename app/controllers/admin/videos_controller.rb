# -*- encoding : utf-8 -*-
class Admin::VideosController < Admin::DocumentsController
  defaults :resource_class => Video
  has_scope :sti_in_document, :default => resource_class.to_s

  private
	def build_associations
	  resource.build_logo unless resource.logo
	end
end
