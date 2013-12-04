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
#  old_fight_rank         :string(255)
#  old_beginner_rank      :string(255)
#  old_mediate_rank       :string(255)
#  old_advanced_rank      :string(255)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
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
class UserBrother < ActiveRecord::Base
  devise :cas_authenticatable, :registerable, :recoverable, :trackable#, :confirmable#, :database_authenticatable
  self.table_name = 'users'
  attr_accessible :password, :password_confirmation

  validates :password, :presence => true , :allow_blank => false, :confirmation => true, :length => 6..20#, :on => :create
  validates :password_confirmation, :presence => true , :allow_blank => false, :confirmation  => true, :length => 6..20#, :on => :create
  attr_accessor :password, :password_confirmation
  
  def reset_password_to_sso
    begin
      params = {password: password }
      uri = Setting.frontend_cas_base_url + "/sso_registers/#{global_id}/reset_password"
      result = MultiJson.decode(Faraday.post(uri,params).body)
      puts result.inspect
      errors.add(account_type, :reset_password) unless result["status"]
    rescue
      self.instance_eval{@errors=ActiveModel::Errors.new(:email=>:reset_password)}
    end
  end

  def reset_password!(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    puts "*"*10
    puts valid?
    if valid?
      clear_reset_password_token
      after_password_reset
      self.reset_password_to_sso
    end
    save
  end
end
