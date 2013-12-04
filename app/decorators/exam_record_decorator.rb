# coding: utf-8
module ExamRecordDecorator
  def user_header_img
  	if user and header = user.user_header and header.link.present?
  		image_tag header.link_url(:mini)
  	else
  		image_tag asset_path("images/user/sculpture.jpg")
  	end
  end
end
