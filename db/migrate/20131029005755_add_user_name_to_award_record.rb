# -*- encoding : utf-8 -*-
class AddUserNameToAwardRecord < ActiveRecord::Migration
  def change
    add_column :award_records, :username, :string
    add_column :award_records, :affiliate_id, :integer
    add_column :award_records, :zone_id, :integer
    add_column :award_records, :zone_name, :string
  end
end
