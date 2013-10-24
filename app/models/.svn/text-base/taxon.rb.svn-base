# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: taxons
#
#  id                :integer          not null, primary key
#  parent_id         :integer
#  position          :integer          default(0)
#  name              :string(255)      not null
#  permalink         :string(255)
#  taxonomy_id       :integer
#  lft               :integer
#  rgt               :integer
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Taxon < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy

  belongs_to :taxonomy, class_name: 'Taxonomy', :touch => true
  belongs_to :parent, class_name: 'Taxon', :foreign_key => "parent_id", :touch => true
  has_many :regulations

  attr_accessible :name, :parent_id, :position, :icon, :description, :permalink, :taxonomy_id,
                  :meta_description, :meta_keywords, :meta_title

  default_scope order: "#{self.table_name}.lft"

  validates :name, presence: true

  def recurse(&block)
    yield self
    self.children.each do |child|
      child.recurse &block
    end
  end

  def full_path
    full_taxons = [self]
    t = self
    while t.parent.present?
      full_taxons << t.parent
      t = t.parent
    end
    full_taxons.reverse.map(&:name).join('-')
  end

  def self.taxon_ids(taxon_id)
    arr = []
    ts = Taxon.where(:id => taxon_id)
    ts.first.recurse{ |c| arr << c.id } if ts.present?
    arr
  end

  #has_attached_file :icon,
  #  styles: { mini: '32x32>', normal: '128x128>' },
  #  default_style: :mini,
  #  url: '/spree/taxons/:id/:style/:basename.:extension',
  #  path: ':rails_root/public/spree/taxons/:id/:style/:basename.:extension',
  #  default_url: '/assets/default_taxon.png'

end
