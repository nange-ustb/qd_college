# -*- encoding : utf-8 -*-
class Admin::TaxonsController < Admin::ResourceController
  respond_to :html, :json, :js

  def index
    @taxons = params[:id].present? ? Taxon.find(params[:id]).children : Taxon.roots
    respond_to do |format|
      format.json { render :json => @taxons.collect{|t| {:attr => {:id => t.id, :name => t.name}, :data => t.name, :state => "closed" } }.to_json }
      #[{"attr" => {"id" => "node_229","rel" => "folder"},"data" => "Esteban","state" => "closed"},{"attr" => {"id" => "node_230","rel" => "folder"},"data" => "safdsdf","state" => "closed"}].to_json}
      format.html {}
    end
  end

  def search
    if params[:ids]
      @taxons = Taxon.where(:id => params[:ids].split(','))
    else
      @taxons = Taxon.where{ name =~ "%#{params[:search_str].to_s}%"}.limit(20)
    end
    respond_to do |format|
      format.json { render :json => @taxons.collect{|t| {:attr => {:id => t.id, :name => t.name}, :data => t.name, :state => "closed" } }.to_json }
      format.html {}
    end
  end

  def create
    @taxon = Taxon.new(params[:taxon])
    if @taxon.save
      respond_with(@taxon) do |format|
        format.json {render :json => @taxon.to_json }
      end
    else
      flash[:error] = "找不到该类别"
      format.json {render :json => {:msg => "找不到该类别"} }
      #respond_with(@taxon) do |format|
      #  format.html { redirect_to @taxonomy ? edit_admin_taxonomy_url(@taxonomy) : admin_taxonomies_url }
      #end
    end
  end

  def edit
    @taxon = Taxon.find(params[:id])
    @permalink_part = @taxon.permalink.split("/").last
  end

  def update
    @taxon = Taxon.find(params[:id])
    parent_id = params[:taxon][:parent_id].blank? ? nil : params[:taxon][:parent_id]
    new_position = params[:taxon][:position]

    if parent_id && new_position #taxon is being moved
      new_parent = parent_id.nil? ? @taxon.parent : Taxon.find(parent_id.to_i)
      new_position = new_position.nil? ? -1 : new_position.to_i

      # Bellow is a very complicated way of finding where in nested set we
      # should actually move the taxon to achieve sane results,
      # JS is giving us the desired position, which was awesome for previous setup,
      # but now it's quite complicated to find where we should put it as we have
      # to differenciate between moving to the same branch, up down and into
      # first position.
      new_siblings = new_parent.children
      if new_position <= 0 && new_siblings.empty?
        @taxon.move_to_child_of(new_parent)
      elsif new_parent.id != @taxon.parent_id
        if new_position == 0
          @taxon.move_to_left_of(new_siblings.first)
        else
          @taxon.move_to_right_of(new_siblings[new_position-1])
        end
      elsif new_position < new_siblings.index(@taxon)
        @taxon.move_to_left_of(new_siblings[new_position]) # we move up
      else
        @taxon.move_to_right_of(new_siblings[new_position-1]) # we move down
      end
      # Reset legacy position, if any extensions still rely on it
      #new_parent.children.reload.each{|t| t.update_column(:position, t.position)}
      new_parent.children.reload.each{|t| t.update_column(:position, t.position)}

      if parent_id
        @taxon.reload
        #@taxon.set_permalink
        @taxon.save!
        @update_children = true
      end
    elsif new_position
      @taxon.move_to_root
      new_position = new_position.nil? ? -1 : new_position.to_i
      new_siblings = Taxon.roots
      if new_position == 0
        @taxon.move_to_left_of(new_siblings.first)
      else
        @taxon.move_to_right_of(new_siblings[new_position-1])
      end
      new_siblings.reload.each{|t| t.update_column(:position, t.position)}
    end

    if params.key? "permalink_part"
      parent_permalink = @taxon.permalink.split("/")[0...-1].join("/")
      parent_permalink += "/" unless parent_permalink.blank?
      params[:taxon][:permalink] = parent_permalink + params[:permalink_part]
    end
    #check if we need to rename child taxons if parent name or permalink changes
    @update_children = true if params[:taxon][:name] != @taxon.name || params[:taxon][:permalink] != @taxon.permalink

    if @taxon.update_attributes(params[:taxon].delete_if{|k, v| ["position"].include?(k) })
      flash[:success] = "更新成功"
      #flash[:success] = flash_message_for(@taxon, :successfully_updated)
    end

    #rename child taxons
    if @update_children
      @taxon.descendants.each do |taxon|
        taxon.reload
        #taxon.set_permalink
        taxon.save!
      end
    end

    respond_with(@taxon) do |format|
      #format.html {redirect_to edit_admin_taxonomy_url(@taxonomy) }
      format.json {render :json => @taxon.to_json }
    end
  end


end
