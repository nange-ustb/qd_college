# -*- encoding : utf-8 -*-
class AdvancedsController < ApplicationController
   def index
	@documents= Document.sti_in_document("Document").search({:level=>"advanced"}).order_position.page(params[:page]).per(5)
	@videos= Video.search({:level=>"advanced"}).order_position
  end
end
