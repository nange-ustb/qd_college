# -*- encoding : utf-8 -*-
class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string     :name, :null => false
      t.timestamps
    end

    create_table :taxons do |t|
      t.references :parent
      t.integer    :position,          :default => 0
      t.string     :name,                             :null => false
      t.string     :permalink
      t.references :taxonomy
      t.integer    :lft
      t.integer    :rgt
      t.string     :icon_file_name
      t.string     :icon_content_type
      t.integer    :icon_file_size
      t.datetime   :icon_updated_at
      t.text       :description
      t.timestamps
    end
  end
end
