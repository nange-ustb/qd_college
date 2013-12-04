# -*- encoding : utf-8 -*-

class QuestionFileUploader < CarrierWave::Uploader::Base

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(xls)
  end

  def filename
    return @temp_name if @temp_name
    @temp_name = Time.now.to_i.to_s + SecureRandom.hex(4) + File.extname(super).downcase if original_filename
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
