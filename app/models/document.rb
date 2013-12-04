# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  author         :string(255)
#  level          :string(255)
#  topic          :string(255)
#  can_download   :boolean          default(FALSE)
#  can_view       :boolean          default(FALSE)
#  position       :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  download_count :integer          default(0)
#  view_count     :integer          default(0)
#  type           :string(255)      default("Document")
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Document < ActiveRecord::Base
  include UpdatePosition
  extend Enumerize
  attr_accessible :type,:body, :level, :title, :topic, :author,:logo_attributes,:file_attributes,:can_download, :can_view,:download_count,:view_count,:user_id
  has_one  :file, as: :viewable,class_name: DocumentFile,dependent: :destroy
  has_one  :logo, as: :viewable,class_name: DocumentLogo,dependent: :destroy

  enumerize :level, :in=>[:mediate,:advanced],default: :mediate,:scope=>true

  accepts_nested_attributes_for :logo , :allow_destroy => true
  accepts_nested_attributes_for :file , :allow_destroy => true

  validates :title,uniqueness: true, :presence => true , :allow_blank => false
  validates :author , :presence => true , :allow_blank => false
  validates :level, :presence => true , :allow_blank => false
  validates :topic, :presence => true , :allow_blank => false
  
  scope :sti_in_document,lambda{|sti|where{type.eq sti}}

  scope :search , lambda{|params|
    where{
      conds = []
      conds << ( title =~ "%#{params[:title]}%" ) if params[:title].present?
      conds << ( author =~ "%#{params[:author]}%" ) if params[:author].present?
      conds << ( level.eq params[:level] ) if params[:level].present?
      conds << ( id.in params[:ids] ) if params[:ids]
      conds.inject{| conds_total , con |  conds_total &= con }
    }
  }

  scope :order_position , lambda{where{}}

  def ppt_2_swf

    if self.type=="Document"

      base_path= self.file.link.current_path

      file_name= base_path

      pdf_name= base_path.split('.').first.to_s+".pdf"
      swf_name= base_path.split('.').first.to_s+".swf"
      final_swf_name= base_path.split('.').first.to_s+"_rfx"+".swf"

      system "python #{Rails.root+"lib"}/DocumentConverter.py #{file_name} #{pdf_name}"
      system "pdf2swf -o #{swf_name} #{pdf_name} -s poly2bitmap"
      system "swfcombine -o #{final_swf_name} #{Rails.root+"lib"}/rfxview.swf viewport=#{swf_name}"
    end
=begin
  python DocumentConverter.py shop.pptx shop.swf
  pdf2swf -o shop.swf shop.pdf
  swfcombine -o shop_rfx.swf rfxview.swf viewport=shop.swf
=end
  end 

  def swf_link
    final_swf_name= self.file.link.url.split('.').first.to_s+"_rfx"+".swf"
    final_swf_name
  end

  @queue = :document_file

  def self.perform(document_id)
    doc = Document.find_by_id(document_id)
    doc.ppt_2_swf if doc
  end

end
