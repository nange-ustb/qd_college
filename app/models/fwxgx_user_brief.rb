# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: [UserBrief]
#
#  UIN              :integer          not null, primary key
#  UserName         :string(30)       not null
#  bAuth            :boolean          default(TRUE), not null
#  AuthGroup        :integer          default(1), not null
#  IsPublic         :integer          default(0)
#  IconUrl          :string(200)
#  sex              :boolean          default(FALSE), not null
#  nRegisterTime    :datetime
#  Nick             :string(30)
#  bOnline          :integer          default(0)
#  sMobile          :string(15)
#  email            :string(61)       not null
#  nLoginTimes      :integer          default(0)
#  company          :string(50)
#  department       :string(50)
#  regionID         :integer          not null
#  RealityName      :string(50)
#  Address          :string(255)
#  ZipCode          :string(31)
#  TelePhone        :string(50)
#  Comment          :string(1000)     default("")
#  UserIP           :string(50)
#  GID              :integer          default(0)
#  ZoneID           :integer          default(0)
#  DogNumber        :string(100)
#  Point            :integer          default(0)
#  UsedPoint        :integer          default(0)
#  SharePoint       :integer
#  IsOriginal       :integer          default(0)
#  IsMatchUser      :integer          default(0)
#  ClientLoginTimes :integer          default(0)
#  IsExpert         :integer          default(0)
#  MobileIsChecked  :integer          default(0)
#  LastLogon        :datetime
#  FilialeID        :integer          default(0)
#  ContributePoint  :integer          default(0)
#  AcceptedRatio    :integer          default(0)
#  count_of_resumes :integer
#  IsCompany        :integer          default(0)
#  IsActive         :integer          default(0)
#  UserType         :integer          default(1)
#  Birthday         :datetime
#  InfoFlag         :integer          default(0)
#  EmailIsValidated :integer          default(0), not null
#  Memo             :string(200)
#  IsWeiBoUser      :integer          default(0)
#  IsBokeUser       :integer          default(0)
#  IsBBSUser        :integer          default(0)
#  folkteamrank     :integer          default(0)
#

# class FwxgxUserBrief < ActiveRecord::Base
#   self.establish_connection "fwxgx_#{Rails.env}"
#   self.table_name = "[UserBrief]"
#   self.primary_key = "UIN"
#   belongs_to :user, :foreign_key => "UIN" , :primary_key => "UserID"
# end
