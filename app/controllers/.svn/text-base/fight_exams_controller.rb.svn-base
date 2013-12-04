# -*- encoding : utf-8 -*-
class FightExamsController < ApplicationController
  before_filter :authenticate_user!, :check_user_level

  layout 'fight'

  def home
    @fight_exam =  current_fight_exam
  end

  def regulations
    @fight_exam =  current_fight_exam
  end

  def start
    @fight_exam = current_fight_exam.started? ? current_fight_exam : (current_fight_exam.start! and current_fight_exam)
    @fight_paper = (current_fight_exam and current_fight_exam.current_fight_paper)
  end

  def create
    @fight_exam =  current_fight_exam
    @fight_paper = (current_fight_exam and current_fight_exam.current_fight_paper)
  end

  def next_stage
    @fight_paper = FightPaper.find(params[:id])
    @fight_exam = @fight_paper.fight_exam
    if !@fight_exam.started?
      flash[:notice] = "您的此次一站到底已经结束或者暂停，请您返回一站到底首页从新开始！"
    elsif @fight_exam.current_stage != @fight_paper.stage
      flash[:notice] = "您可能在别的浏览器上答题，请您确认或者关闭浏览器从新开始！"
    else
      @fight_paper.deal_with_answer(params[:answer])
      @fight_exam.reload
      @fight_paper.reload
    end
  end

  def pause
    @fight_exam = current_fight_exam.started? ? current_fight_exam : (current_fight_exam.start! and current_fight_exam)
    @fight_exam.pause!
  end

  private
  def current_fight_exam
    current_user and current_user.current_fight_exam
  end

  def check_user_level
    unless ['mediate', 'advanced'].include? current_user.try(:student).try(:level)
       flash[:notice] = "只有中级和高级的学员才能进行一战到底！"
       redirect_to(root_path)  and return
    end
  end

end
