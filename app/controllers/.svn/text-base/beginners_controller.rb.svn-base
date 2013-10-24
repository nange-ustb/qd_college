# -*- encoding : utf-8 -*-
class BeginnersController < ApplicationController
  def index
  	@taxons = Taxon.select("id,name,parent_id").group_by(&:parent_id)
  end

  def show
  	search ={:taxon_id=>params[:taxon_id],:description=>params[:description]}
  	@regulations = Regulation.search(search)
  end
end
