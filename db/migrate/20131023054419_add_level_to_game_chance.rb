# -*- encoding : utf-8 -*-
class AddLevelToGameChance < ActiveRecord::Migration
  def change
    add_column :game_chances, :level, :string
  end
end
