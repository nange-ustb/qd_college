# -*- encoding : utf-8 -*-
class BeginnersController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@taxons = Taxon.select("id,name,parent_id").group_by(&:parent_id)
  	@rankings= ExamRecord.valid.with_level(:beginner).limit(10).order("correct desc,created_at asc")
  end

  def show
  	search ={:taxon_id=>params[:taxon_id],:description=>params[:description]}
  	@regulations = Regulation.search(search)
  end
end
