# -*- encoding : utf-8 -*-
class RemoveCodeAndUniqIdFromPermissions < ActiveRecord::Migration
  def up
    remove_column :permissions , :uniq_id
    remove_column :permissions , :code
  end

  def down
    
  end
end
