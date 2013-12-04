# -*- encoding : utf-8 -*-
class AddDownloadCountAndViewCountToDocumnet < ActiveRecord::Migration
  def change
  	add_column :documents, :download_count, :integer,default: 0
  	add_column :documents, :view_count, :integer,default: 0
  	add_column :documents, :type, :string,default: "Document"
  end
end
