# -*- encoding : utf-8 -*-
class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.string :author
      t.string :level
      t.string :topic
      t.boolean :can_download,default: false
      t.boolean :can_view,default: false
      t.integer :position,:default=>0

      t.timestamps
    end
    add_index :documents, [:title]
  end
end
