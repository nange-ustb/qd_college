# -*- encoding : utf-8 -*-
class DocumentWorker
  include Sidekiq::Worker
  def perform(document_id, count)
  	Document.find_by_id(document_id).ppt_2_swf
  end
end
