# -*- encoding : utf-8 -*-
class SchoolsController < ApplicationController
  ACTIONS = [:beginner,:mediate,:advanced]
  before_filter :authenticate_user!, :only => (ACTIONS + %w(create show index))
  before_filter :check_completed_info,:only=>:beginner
  before_filter :unfinishied_exam,:set_level,only: ACTIONS
  before_filter :formulate_the_exam,only: (ACTIONS + %w(create))
  before_filter :includ_questions,only: ACTIONS

  def index
      respond_to do|f|
        f.html do
          @zones = Affiliate.select("code,name").collect {|z| [ z.name, z.code ] }
          @exam_records = {}
          @tops = {}
          ExamRecord.level.values.each do |level|
            %w(pass nopass).each do |status|
              @exam_records["#{level}_#{status}".to_sym] = ExamRecord.valid.order("correct desc,created_at asc").with_level(level).send(status).page(1).per(10)
            end
          end
        end

        f.js do 
          scope = ExamRecord.search(params[:search])
          scope = scope.reorder(ExamRecord.order_str(params[:search][:order_str]))
          @top_three = scope.limit(3).select('exam_records.*')
          top_three_ids = @top_three.select("exam_records.id").map(&:id)
          @exam_records = scope.where{exam_records.id.not_in top_three_ids}.select('exam_records.*').page(params[:page]).per(7)
        end
      end
  end

  def beginner
    render "beginner"
  end

  def mediate
    render "beginner"
  end

  def advanced
    render "beginner"
  end

  def create
    answers = params[:exam][:questions_attributes].values
    @exam.calculate_achievement(answers,@student)
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
    redirect_to :action=>@exam.level and return if Time.now > @exam.created_at.since((@exam.exam_time_limit + 10).minutes)
  end

  private
  def check_completed_info
      unless current_user.completed_info?
        flash[:notice] = "您只有完善信息，才可以进行在线检测！"
        redirect_to edit_user_registration_path and return
      end
  end

  def unfinishied_exam
    sign_up
    if exam = @student.exams.unfinished.order_time_desc.first and exam.level != params[:action]
      flash[:notice] = '你有未完成的评测，去完成'
      redirect_to :action=>exam.level and return
    end
  end

  def formulate_the_exam
    sign_up
    unless is_in_accordance_with_the_student_level?
      Rails.logger.info "*"*10
      flash[:notice] = '你还不能参加该级别的测试'
      redirect_to :action=>@student.prev_level and return
    end

    find_admission_card
    if @exam.nil?
      Rails.logger.info "-"*10
      flash[:notice] = '评测超时或者该评测已经结束'
      redirect_to root_path and return
    end

    unless exam_time_is_not_expired?
      Rails.logger.info "+"*10
      flash[:notice] = '评测超时或者该评测已经结束'
      redirect_to root_path and return
      # redirect_to :action=>session[:action] and return
    end
  end

  def includ_questions
    @questions = @exam.questions.reload
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
    @exam = @student.exams.unfinished.with_level(session[:action]).order_time_desc.first
    if params[:action] != 'create' and  @exam.nil?
      @exam = Exam.unfinished.with_level(session[:action].to_sym).find_or_create_by_student_id(:student_id=>@student.id)
      ExamWorker.perform_at((@exam.exam_time_limit + 1).minutes.from_now, @exam.id, 1)
      # ExamWorker.perform_at((1).minutes.from_now, @exam.id, 1)
    end
  end

  def exam_time_is_not_expired?
    (@exam.spare_exam_time + 300) > 0
  end
end
