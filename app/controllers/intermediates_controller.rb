# -*- encoding : utf-8 -*-
class IntermediatesController < ApplicationController
  def index
	@documents= Document.sti_in_document("Document").search({:level=>"mediate"}).order_position.page(params[:page]).per(5)
	@videos= Video.search({:level=>"mediate"}).order_position
  end
end
