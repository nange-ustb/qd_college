# -*- encoding : utf-8 -*-
class CreateVideoNodes < ActiveRecord::Migration
  def change
    create_table :video_nodes do |t|
      t.string :link
      t.string :title
      t.integer :video_id
      t.integer :position,:default=>0

      t.timestamps
    end
  end
end
