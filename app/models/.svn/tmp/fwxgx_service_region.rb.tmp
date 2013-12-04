# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ServiceRegion
#
#  regionID      :integer          not null
#  serverID      :integer
#  regioncode    :string(8)        not null
#  regionname    :string(31)       not null
#  describe      :string(255)
#  IncludeRegion :string(1000)
#  IsSub         :integer          default(0)
#  FilialeID     :integer
#  Continue2011  :integer
#  NewUser2012   :integer
#  Continue2012  :integer
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: ServiceRegion
#
#  regionID      :integer          not null
#  serverID      :integer
#  regioncode    :string(8)        not null
#  regionname    :string(31)       not null
#  describe      :string(255)
#  IncludeRegion :string(1000)
#  IsSub         :integer          default(0)
#  FilialeID     :integer
#  Continue2011  :integer
#  NewUser2012   :integer
#  Continue2012  :integer
#
class FwxgxServiceRegion < ActiveRecord::Base
  establish_connection "fwxgx_#{Rails.env}".to_sym
  self.table_name = "ServiceRegion"

  #require 'iconv'
  #Iconv.iconv('UTF-8', 'GBK', b.regionname)
  LOCATION_INFOS =  FwxgxServiceRegion.all.inject({}){|a, b| a.merge!({"#{b.regionID}" => b.regionname})}
  Filiale_INFOS =  FwxgxServiceRegion.all.inject({}){|a, b| a.merge!({"#{b.FilialeID}" => b.regionname})}

  class << self
    def filiale_id_by_regionID(id)
      FwxgxServiceRegion.find_by_regionID(id).FilialeID
    end

    def regionname_by_regionID(id)
      fsr = FwxgxServiceRegion.find_by_regionID(id)
      fsr.present? ? fsr.regionname : ''
    end

    def regionname_by_filialeID(id)
      fsr = FwxgxServiceRegion.find_by_FilialeID(id)
      fsr.present? ? fsr.regionname : ''
    end
  end
end
