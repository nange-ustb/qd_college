# -*- encoding : utf-8 -*-

class DocumentFileUploader < CarrierWave::Uploader::Base
   
  def store_dir
    "user_#{Rails.env}/assets/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(txt ppt pptx pdf xls xlsx doc docx)
  end

  def filename
  	return @temp_name if @temp_name
  	@temp_name = Time.now.to_i.to_s + SecureRandom.hex(4) + File.extname(super).downcase if original_filename
  end
end
