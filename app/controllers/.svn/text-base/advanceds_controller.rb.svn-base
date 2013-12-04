# -*- encoding : utf-8 -*-
class AdvancedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user_level

  def index
    @documents= Document.sti_in_document("Document").search({:level=>"advanced"}).order_position.page(params[:page]).per(5)
    @videos= Video.search({:level=>"advanced"}).order_position
    @ads= Advertisement.limit(2)
    @rankings= ExamRecord.valid.with_level(:advanced).limit(10).order("correct desc,created_at asc")
  end

  private
  def check_user_level
    unless ['advanced'].include? current_user.try(:student).try(:level)
      flash[:notice] = "只有通过中级在线评测的学员才能进行进入高级级课程！"
      redirect_to(root_path)  and return
    end
  end
end
