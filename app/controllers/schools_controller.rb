# -*- encoding : utf-8 -*-
class SchoolsController < ApplicationController
  ACTIONS = [:beginner,:mediate,:advanced]
  before_filter :authenticate_user!, :only => (ACTIONS << "create" << "show")
  before_filter :unfinishied_exam,:set_level,only: ACTIONS
  before_filter :formulate_the_exam,only: (ACTIONS << "create")
  before_filter :includ_questions,only: ACTIONS
  

  ACTIONS.each do |method_name|
    define_method(:method_name ){}
  end

  def create
  	answers = params[:exam][:questions_attributes].values
  	@student = @exam.calculate_achievement(answers)
    @student.take_the_game_chance
    @exam.save 
    @student.save

    if @student.game_chance_level
      render :success
    else
      render :failure
    end
  end

  def show
    @exam = current_user.student.exams.finished.where(:id=>params[:id]).includes(:questions).first
    redirect_to :action=>@exam.level and return if Time.now > @exam.created_at.since((@exam.exam_time_limit + 0.5).minutes)
  end

  private
  def unfinishied_exam
    sign_up
    if exam = @student.exams.unfinished.order_time_desc.first and exam.level != params[:action]
      flash[:notice] = '你有未完成的评测，去完成？'
      redirect_to :action=>exam.level and return 
    end
  end

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

  def includ_questions
    @questions = @exam.questions
  end

  def set_level
      session[:action] = params[:action]
  end

  def sign_up
	 @student ||= Student.find_or_create_by_user_id(:user_id=>current_user.id)
  end

  def is_in_accordance_with_the_student_level?
  	@student.is_in_accordance_with_the_student_level?(session[:action])
  end

  def find_admission_card
  	unless @exam = @student.exams.unfinished.with_level(session[:action]).order_time_desc.first
  	   @exam = Exam.with_level(session[:action].to_sym).find_or_create_by_student_id(:student_id=>@student.id)
       ExamWorker.perform_at((@exam.exam_time_limit + 1).minutes.from_now, @exam.id, 1)
  	end
  end

  def exam_time_is_not_expired?
  	@exam.spare_exam_time > 0
  end
end
