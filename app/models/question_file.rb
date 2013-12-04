# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: question_files
#
#  id            :integer          not null, primary key
#  question_type :string(255)
#  title         :string(255)
#  file_url      :string(255)
#  is_inport     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
class QuestionFile < ActiveRecord::Base
  attr_accessible :file_url, :is_inport, :title ,:question_type
  validates :question_type , :title ,:file_url , presence: true
  mount_uploader :file_url, QuestionFileUploader

  has_many :questions

  extend Enumerize
  extend ActiveModel::Naming

  enumerize :question_type, in:[:QuestionOnline, :QuestionStand]

  scope :search , lambda{|params|
    where{
      conds = []
      conds << ( question_type.eq params[:question_type] ) if params[:question_type].present?
      conds << ( title =~ ("%" + params[:title] +"%") ) if params[:title].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.order("created_at desc")
  }

  def inport_question
    QuestionFile.transaction do
      Spreadsheet.client_encoding = 'UTF-8'
      book = Spreadsheet.open(File.join(Rails.root,"public","#{self.file_url_url}"))
      book.worksheets.each do |sheet|
          header = sheet.row(0)
          header = ["category","title","a", "b", "c", "d", "e", "f", "answer", "type", "question_file_id"]
          
          (1 .. sheet.last_row_index).each do |i|
              cur_row= sheet.row(i)
              if self.question_type=="QuestionOnline"
                cur_row[0]= Hash["#{self.question_type}".constantize.category.options]["#{cur_row[0].strip}"]
              else
                cur_row[0]= cur_row[0].try(:strip)
              end   
              question_file_id= self.id 
              c_type= self.question_type  
              values= cur_row + [c_type,question_file_id ]
             # values= values.map!(&:to_s).map!(&:strip)

              row = Hash[[header, values].transpose]
              attributes = row.to_hash.slice(*Question.accessible_attributes)
              a=Question.create(attributes)
              logger.info a.errors.inspect
          end
      end
    end
  end 

end
