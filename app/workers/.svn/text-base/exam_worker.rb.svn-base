# -*- encoding : utf-8 -*-
class ExamWorker
  include Sidekiq::Worker
  def perform(exam_id,count)
  	Exam.unfinished.where(:id=>exam_id).update_all(:finished=>true)
  end
end
