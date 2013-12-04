# -*- encoding : utf-8 -*-
class AddColumnStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string,:default=>"on"
  end
end
