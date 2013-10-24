# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: regulations
#
#  id          :integer          not null, primary key
#  taxon_id    :integer
#  description :text
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Regulation < ActiveRecord::Base
  attr_accessible :taxon_id, :description
  belongs_to :taxon, :touch => true

  default_scope order: "#{self.table_name}.position"

  scope :search, lambda{ |params|
    where{
      conds = []
      if params[:taxon_id].present?
        conds << ( taxon_id.in Taxon.taxon_ids(params[:taxon_id]))
      end
      conds << ( description =~  "%#{params[:description].strip}%" ) if params[:description].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }
  }

  def taxon_id_text
    self.taxon.full_path if self.taxon.present?
  end
end
