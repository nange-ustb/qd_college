# -*- encoding : utf-8 -*-
class Admin::QuestionFilesController < Admin::ResourceController
	helper_method :attributes
	has_scope :search , :only => [:index] ,:type => :hash, :default => {:title=>""}

	def new 
		@question_file= QuestionFile.new(:question_type=> params[:q] )
	end 

	def create
		create! do |success, failure|
		      failure.html {
		        @question_file = resource
		        render :new   }
		      success.html {
		        redirect_to inport_admin_question_file_path(resource) and return
		      }
	    end
	end 

	def inport
		@question_file= QuestionFile.find params[:id]
		@question_file.inport_question
		@question_file.is_inport=true
		if @question_file.save
			# flash[:notice] = "导入成功!!"
		end 
		redirect_to :action => :index, :search => {:question_type=> @question_file.question_type} and return
	end 

	private 
  	def attributes
  		["question_type", "title", "is_inport", "created_at"] 
  	end 			
end
