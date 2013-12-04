# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: administrators
#
#  id                 :integer          not null, primary key
#  user_name          :string(255)      not null
#  real_name          :string(255)
#  nick_name          :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Administrator < ActiveRecord::Base

  #users :cas_authenticatable
  devise :database_authenticatable

  attr_accessible :email, :nick_name, :user_name, :real_name , :affiliate_ids , :role_ids , :encrypted_password

  validates :user_name, :presence => true

  has_many :administrator_roles , :dependent => :destroy
  has_many :roles  , :through => :administrator_roles
  has_many :information

  has_many :administrator_affiliates , :dependent => :destroy
  has_many :affiliates , :through => :administrator_affiliates

  scope :search , lambda{|params|
    name_str = params[:user_name].present? ? params[:user_name].strip : ""
    roles_str = params[:role].present? ? params[:role].to_i : ""
    joins{administrator_roles}.where{
      conds = []
      conds << ( user_name =~ ("%" + name_str +"%") ) if params[:user_name].present?
      conds << ( administrator_roles.role_id == params[:role].to_i ) if params[:role].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }
  }

  def self.current
    Thread.current[:administrator]
  end
  def self.current=(user)
    Thread.current[:administrator] = user
  end

  def has_role?(title)
    roles.exists?(:level => title.to_s.downcase)
  end

  def admin?
    has_role?('superman')
  end
end
