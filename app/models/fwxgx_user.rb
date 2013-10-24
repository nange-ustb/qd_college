# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: [User]
#
#  UserID          :integer          not null, primary key
#  AreaID          :integer
#  UserCardTypeID  :integer          default(144137)
#  LoginName       :string(31)       not null
#  Password        :string(254)      not null
#  UserName        :string(31)
#  Nickname        :string(31)
#  Mobile          :string(31)
#  Phone           :string(255)      default("")
#  EMail           :string(255)
#  Homepage        :string(254)
#  LastLoginDate   :datetime         not null
#  SmsAuthenticode :integer
#  IsAudited       :boolean          default(TRUE)
#  IsDeleted       :boolean          default(FALSE), not null
#

# class User < ActiveRecord::Base
#   self.establish_connection "fwxgx_#{Rails.env}"
#   self.table_name = "[User]"
#   self.primary_key = "UserID"
#   has_one :user_brief, :foreign_key => "UIN" , :primary_key => "UserID"
# end
