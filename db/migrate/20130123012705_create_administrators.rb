# -*- encoding : utf-8 -*-
class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :user_name, :null => false
      t.string :real_name
      t.string :nick_name
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
