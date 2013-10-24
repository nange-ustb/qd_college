# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: taxonomies
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Taxonomy < ActiveRecord::Base
  validates :name, presence: true

  attr_accessible :name

  has_many :taxons
  has_one :root, conditions: { parent_id: nil }, class_name: "Taxon",
          dependent: :destroy

  after_save :set_name

  default_scope order: "#{self.table_name}.position"

  private
  def set_name
    if root
      root.update_column(:name, name)
    else
      self.root = Taxon.create!({ taxonomy_id: id, name: name }, without_protection: true)
    end
  end

end
