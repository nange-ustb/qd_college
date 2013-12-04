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
class User < ActiveRecord::Base
  extend Enumerize

  enumerize :level, in:[:beginner, :mediate, :advanced], default: :beginner
  enumerize :gender, in:[:true, :false], default: :true
  enumerize :status, in:[:on, :off], default: :on, predicates: true
  enumerize :seniority, in:[:one, :three,:more], default: :one

  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable, :registerable, :recoverable, :trackable#, :confirmable#, :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :global_id, :remember_me,
                  :username, :name, :gender, :id_card, :mobile, :qq, :zone_id, :address, :company, :company_address,
                  :seniority, :level,:status,:user_header_attributes,:province_id

  belongs_to :zone
  belongs_to :affiliate
  has_one :student, dependent: :destroy
  has_many :award_records, dependent: :destroy
  has_one :user_header, as: :viewable, class_name: UserHeader, dependent: :destroy
  has_many :fight_exams, dependent: :destroy
  has_one :ranking_list_year, :class_name => "RankingListYear", dependent: :destroy
  has_many :ranking_list_weeks, :class_name => "RankingListWeek", dependent: :destroy
  has_many :exam_records, dependent: :destroy

  scope :current_ranking_list_week, lambda{ where(:stage => RankingListWeek.current_week).first }

  delegate :name, :full_name, :province_name, :to => :zone, :prefix => :zone, :allow_nil => true

  validates :username, :presence => true, :allow_blank => false
  validates :email, :presence => true, :allow_blank => false, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :unless => :come_from_sso?
  validates :mobile, :format => { with: /^1[0-9]{10}$/ }, :presence => true, :allow_blank => false,:on=>:update
  validates :password, :presence => true, :allow_blank => false, :confirmation => true, :length => 6..20, :on => :create
  validates :password_confirmation, :presence => true, :length => 6..20, :on => :create
  validate  :check_register_uniq, :on=>:create, :unless => :come_from_sso?
  validates :zone_id, :presence => true, :allow_blank => false
  validates :name, :presence => true , :allow_blank => false, :on=>:update
  validates :address, :presence => true , :allow_blank => false, :on=>:update

  accepts_nested_attributes_for  :user_header, :allow_destroy => true

  before_validation :update_username_info
  before_create :syn_info_to_sso
  after_create :init_ranking_list

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
      conds << ( level.eq params[:level] ) if params[:level].present?
      conds << ( username =~ ("%" + params[:username] +"%") ) if params[:username].present?
      # conds << ( zone_id.eq params[:zone_id] ) if params[:zone_id].present?
      conds << ( zone.affiliate_id.eq params[:affiliate_id] ) if params[:affiliate_id].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.order("users.created_at desc")
  }

  default_scope lambda{
    unless Administrator.current.blank? or Administrator.current.has_role?('superman')
      includes(:zone).where{
        conds = []
        conds << ( zone.affiliate_id.in Affiliate.of_administrator.pluck(:code) )
        conds.inject{| conds_total , con |  conds_total &= con }
      }.readonly(false)
    end
  }


  def cas_extra_attributes=(extra_attributes)
    self.username = extra_attributes['loginname']
    self.mobile = extra_attributes['mobile_phone'] if self.mobile.blank?
    self.email = extra_attributes['email'] || ''
    self.global_id = extra_attributes['global_id']

    self.password = '123456' if self.password.blank?
    self.password_confirmation = '123456' if self.password_confirmation.blank?
    self.zone_id = 0 if self.zone_id.blank?

    self.syn_fwxgx_info(self.username) if self.new_record?
  end

  def syn_fwxgx_info(loginname)
    begin
      fub = FwxgxUserBrief.find_by_UserName(loginname)
      if fub.present?
        self.name = fub.RealityName if self.name.blank?
        self.mobile = fub.sMobile if self.mobile.blank?
        self.company = fub.company if self.company.blank?
        self.address = fub.Address if self.address.blank?
        if self.zone_id.blank? || self.zone_id == 0
          if Setting.sync_fwxgx_user_info == "on"
            fwxgx_zone = Zone.where(" name like ? ", "%#{FwxgxServiceRegion::LOCATION_INFOS[fub.regionID.to_s]}%").try(:first)
            self.zone_id = fwxgx_zone.id if fwxgx_zone.present?
          end
        end
        if fub.IconUrl.present?
          image_src = Setting.fwxgx_image_url + "/downfile/UserFace/" + fub.UIN.to_s + "_" + fub.IconUrl.to_s
          build_user_header( :remote_link_url => image_src )
        else
          return nil
        end
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
      if result
        return true
      else
        errors.add('email', :existing)
      end
    rescue
      errors.add('email', :register_uniq)
      return false
    end
  end

  def syn_info_to_sso
    build_student
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
    #if valid?
    clear_reset_password_token
    after_password_reset
    self.reset_password_to_sso
    #end
    self.save(:validate => false)
  end
  def current_fight_exam
    fight_exams.where(:status => ["new", "started", "paused"]).first || fight_exams.create
  end



  def init_ranking_list
    self.create_ranking_list_year
    self.ranking_list_weeks.create(:stage => RankingListWeek.current_week)
  end

  # About ranking list
  def scored(score)
    if score > self.high_score
      $redis.zadd("high_scores", score, self.id)
    end
  end

  def rank
    rly = self.ranking_list_year
    (rly.blank? or rly.gold_count <= 0) ? '无' : RankingListYear.where(" gold_count > ? or (gold_count = ? and updated_at <= ?) ", self.high_score, self.high_score, rly.try(:updated_at)).count
    #redis_rank = $redis.zrevrank("high_scores", self.id)
    #redis_rank ? redis_rank.to_i + 1 : '无'
  end

  def high_score
    $redis.zscore("high_scores", self.id).to_i
  end

  def self.top_3
    $redis.zrevrange("high_scores", 0, 2).map{|id| User.find(id)}
  end

  def week_scored(score)
    if score > self.week_high_score
      $redis.zadd("week_#{RankingListWeek.current_week}_high_scores", score, self.id)
    end
  end

  def week_rank
    cwr = self.ranking_list_weeks.current_week_records.try(:first)
    (cwr.blank? or cwr.gold_count <= 0) ? '无' : RankingListWeek.where(" stage = ? and (gold_count > ? or (gold_count = ? and updated_at <= ?)) ", RankingListWeek.current_week, self.week_high_score, self.week_high_score, cwr.updated_at).count
    #redis_week_rank = $redis.zrevrank("week_#{RankingListWeek.current_week}_high_scores", self.id)
    #redis_week_rank ? redis_week_rank.to_i + 1 : '无'
  end

  def week_high_score
    $redis.zscore("week_#{RankingListWeek.current_week}_high_scores", self.id).to_i
  end

  def self.week_top_3
    $redis.zrevrange("week_#{RankingListWeek.current_week}_high_scores", 0, 2).map{|id| User.find(id)}
  end

  def completed_info?
    self.mobile? and self.zone_id.to_i > 0 and self.name? and self.address? and self.email?
  end



  #change_status up down flat
  def fight_rank
    rly = self.ranking_list_year
    new_fight_rank = (rly.blank? || rly.gold_count.to_i <= 0) ? '无' : RankingListYear.where(" gold_count > ? or (gold_count = ? and updated_at <= ?) ", self.high_score, self.high_score, rly.try(:updated_at)).count

    if self.new_fight_rank.to_i != new_fight_rank.to_i
      self.old_fight_rank = self.new_fight_rank
      self.new_fight_rank = new_fight_rank
      self.save
    end

    @fight_rank = new_fight_rank
    @fight_rank_change = rank_change(self.old_fight_rank, self.new_fight_rank)
    @fight_rank
    #redis_rank = $redis.zrevrank("high_scores", self.id)
    #redis_rank ? redis_rank.to_i + 1 : '无'
  end

  def home_fight_rank
    (fight_rank.to_i == 0 ? "<span>"+fight_rank.to_s+"</span>" : "第<span>"+fight_rank.to_s+"</span>名").html_safe
  end

  def fight_rank_change
    @fight_rank_change || 'flat'
  end


  #has_one :beginner_exam_record, :class_name => "ExamRecord", :conditions => " level = 'beginner' "
  #has_one :mediate_exam_record, :class_name => "ExamRecord", :conditions => " level = 'mediate' "
  #has_one :advanced_exam_record, :class_name => "ExamRecord", :conditions => " level = 'advanced' "
  #def beginner_rank
  #  er = self.beginner_exam_record
  #  old_beginner_rank = self.old_beginner_rank
  #  new_beginner_rank = er.blank? ? '无' : ExamRecord.where(" level = ? and (gold_count > ? or (gold_count = ? and updated_at <= ?)) ", "beginner", er.correct, self.correct, er.try(:updated_at)).count
  #  self.old_beginner_rank = new_beginner_rank
  #  self.save
  #  @beginner_rank = new_beginner_rank
  #  @beginner_rank_change = rank_change(old_beginner_rank, new_beginner_rank)
  #  @beginner_rank
  #end
  #
  #def beginner_rank_change
  #  @beginner_rank_change || 'flat'
  #end
  User.level.values.each do |lv|
    has_one "#{lv}_exam_record".to_sym, :class_name => "ExamRecord", :conditions => " level = '#{lv}' "

    class_eval <<-METHODS
      def #{lv}_rank
        er = self.#{lv}_exam_record
        new_#{lv}_rank = (er.blank? || er.correct == 0) ? '无' : ExamRecord.where(" correct > 0 and level = ? and (correct > ? or (correct = ? and created_at <= ?)) ", "#{lv}", er.correct, er.correct, er.try(:created_at)).count

        if self.new_#{lv}_rank.to_i != new_#{lv}_rank.to_i
          self.old_#{lv}_rank = self.new_#{lv}_rank
          self.new_#{lv}_rank = new_#{lv}_rank
          self.save
        end

        @#{lv}_rank = new_#{lv}_rank
        @#{lv}_rank_change = rank_change(self.old_#{lv}_rank, self.new_#{lv}_rank)
        @#{lv}_rank
      end

      def home_#{lv}_rank
         #(#{lv}_rank.to_i == 0 ? "<span>"+#{lv}_rank.to_s+"</span>" : "第<span>"+#{lv}_rank.to_s+"</span>名").html_safe
         (#{lv}_rank.to_i == 0 ? "<span>"+#{lv}_rank.to_s+"</span>" : "第<span>"+#{lv}_rank.to_s+"</span>名").html_safe
      end

      def #{lv}_rank_change
        @#{lv}_rank_change || 'flat'
      end
    METHODS
  end

  def rank_change(old_rank, new_rank)
    if old_rank.to_i < new_rank.to_i
      return "up"
    elsif old_rank.to_i == new_rank.to_i
      return "flat"
    elsif old_rank.to_i > new_rank.to_i
      return "down"
    end
  end


end
