# -*- encoding : utf-8 -*-
class ExamsController < ApplicationController
  before_filter :formulate_the_exam,only: [:beginner]
  def beginner
  end

  def show
  	@regulations = Regulation.search({:taxon_id=>params[:id]})
  end

  private
  def formulate_the_exam
  	sign_up
  	unless is_in_accordance_with_the_student_level?
  		flash[:notice] = '你还不能参加该级别的测试'
  		redirect_to root_path and return 
  	end

  	find_admission_card
  	unless exam_time_is_not_expired?
  		flash[:notice] = '评测超时或者该评测已经结束'
  		redirect_to root_path and return 
  	end
  end

  def sign_up
	@student = Student.find_or_create_by_user_id(:user_id=>current_user.id)
  end

  def is_in_accordance_with_the_student_level?
  	@student.is_in_accordance_with_the_student_level?(params[:action])
  end

  def find_admission_card
  	unless @exam = @student.exams.order_time_desc.first
  	   @exam = Exam.with_level(params[:action].to_sym).find_or_create_by_student_id(:student_id=>@student.id)
  	end
  end

  def exam_time_is_not_expired?
  	!@exam.finished and  @exam.spare_exam_time > 0
  end
end
