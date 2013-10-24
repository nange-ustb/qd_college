# -*- encoding : utf-8 -*-
class Admin::QuestionStandsController < Admin::ResourceController
	helper_method :attributes
	has_scope :search , :only => [:index] ,:type => :hash, :default => {:title=>""}
  def index
  		index!{
  			respond_to do|f|
	      f.xls{
	      	 titles = %w(类别 标题 选项A 选项B 选项C 选项D 选项E 选项F 正确答案 创建时间)
          attrs = %w(category_text title a b c d e f answer created_at)
          send_xls_data(collection,titles,attrs)
          return	       
	      }
	      f.html{}
    		end 
  		}
  end

  private 
  	def attributes
  		 [ "category", "title","a", "b", "c", "d", "e", "f", "answer"] 		
  	end 	
end
