# -*- encoding : utf-8 -*-
module ApplicationHelper
  def nokogiri_strip_tags(text)
    Nokogiri.HTML(text).text
  end
end
