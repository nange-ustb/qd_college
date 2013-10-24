# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  username               :string(255)
#  name                   :string(255)
#  gender                 :string(255)      default("male")
#  id_card                :string(18)
#  mobile                 :string(11)
#  qq                     :string(255)
#  zone_id                :integer
#  address                :string(255)
#  company                :string(255)
#  company_address        :string(255)
#  seniority              :string(255)
#  level                  :string(255)
#  global_id              :integer          default(0), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  status                 :string(255)      default("on")
#

# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  extend Enumerize

  enumerize :level, in:[:beginner, :mediate, :advanced], default: :beginner
  enumerize :gender, in:[:male, :female], default: :male
  enumerize :status, in:[:on, :off], default: :on, predicates: true

  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :confirmable#, :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :global_id, :remember_me,
                  :username, :name, :gender, :id_card, :mobile, :qq, :zone_id, :address, :company, :company_address,
                  :seniority, :level,:status

  belongs_to :zone
  belongs_to :affiliate
  has_one :student, dependent: :destroy
  has_many :award_records, dependent: :destroy
  has_one :user_header, as: :viewable, class_name: UserHeader, dependent: :destroy

  delegate :name, :full_name, :to => :zone, :prefix => :zone, :allow_nil => true

  validates :username, :presence => true, :allow_blank => false
  validates :email, :presence => true, :allow_blank => false, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :on=>:create
  validates :mobile, :format => { with: /^1[0-9]{10}/ }, :allow_blank => true
  validates :password, :presence => true , :allow_blank => false, :confirmation => true, :length => 6..20, :on => :create
  validates :password_confirmation, :presence => true , :allow_blank => false, :confirmation  => true, :length => 6..20, :on => :create
  validate  :check_register_uniq ,:on=>:create, :unless => :come_from_sso?
  validates :zone_id, :presence => true, :allow_blank => false

  before_validation :update_username_info
  before_create :syn_info_to_sso

  before_create :init_user_level
  def init_user_level
    self.level="beginner"
    self.status="on"
  end 

  def update_username_info
    self.username = self.email if self.username.blank?
  end

  scope :search , lambda{|params|
    includes(:zone).where{
      conds = []
      conds << ( level.eq params[:levle] ) if params[:level].present?
      conds << ( username =~ ("%" + params[:username] +"%") ) if params[:username].present?
     # conds << ( zone_id.eq params[:zone_id] ) if params[:zone_id].present?
      conds << ( zone.affiliate_id.eq params[:affiliate_id] ) if params[:affiliate_id].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.order("users.created_at desc")
  }


  def cas_extra_attributes=(extra_attributes)
    self.username = extra_attributes['loginname']
    self.mobile = extra_attributes['mobile_phone']
    self.email = extra_attributes['email']
    self.global_id = extra_attributes['global_id']
    self.password = '123456' if self.password.blank?
    self.password_confirmation = '123456' if self.password_confirmation.blank?
    self.zone_id = 0 if self.zone_id.blank?
    build_user_header( :link => fwxgx_user_header(username) )
  end

  def fwxgx_user_header(loginname)
    begin
      uri = "#{Setting.dyjh_url}/sessions/get_userbrief?loginname=#{Rack::Utils.escape(loginname)}"
      user_info = MultiJson.decode( Faraday.post(uri).body )
      if user_info.class == Hash and  user_info["userbrief"].class == Hash
        userbrief = user_info["userbrief"]
        return image_src = Setting.fwxgx_image_url + "/downfile/UserFace/" + userbrief["UIN"].to_s + "_" + userbrief["IconUrl"].to_s
      else
        return nil
      end
    rescue Exception
      return nil
    end
  end

  def come_from_sso?
    self.global_id > 0
  end

  def check_register_uniq
    begin
      params = {email: email,mobile_phone: mobile}
      uri = Setting.frontend_cas_base_url + "/bitaec_registers/check_register_info"
      result = MultiJson.decode(Faraday.get(uri,params).body)["result"]
      errors.add('email', :existing) unless result
    rescue
      errors.add('email', :register_uniq)
    end
  end

  def syn_info_to_sso
    begin
      params = {email: email, loginname: username, password: password,
                come_from: "qdxy.glodon.com", mobile_phone: mobile, email_is_validate: false}
      uri = Setting.frontend_cas_base_url + "sso_registers"
      result = MultiJson.decode(Faraday.post(uri, params).body)
      self.global_id = result["global_id"] if result["status"]
    rescue
      errors.add('email', :syn_info)
      return false
    end unless come_from_sso?
  end

  def reset_password_to_sso
    begin
      params = {password: password }
      uri = Setting.frontend_cas_base_url + "/sso_registers/#{global_id}/reset_password"
      result = MultiJson.decode(Faraday.post(uri,params).body)
      errors.add(account_type, :reset_password) unless result["status"]
    rescue
      self.instance_eval{@errors=ActiveModel::Errors.new(:email=>:reset_password)}
    end
  end

  def reset_password!(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation

    if valid?
      clear_reset_password_token
      after_password_reset
      self.reset_password_to_sso
    end

    save
  end

end
