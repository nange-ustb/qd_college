# -*- encoding : utf-8 -*-

class DocumentLogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "user_#{Rails.env}/assets/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  version :large do
    process :resize_to_fill => [674, 381]
  end

  version :middle do
    process :resize_to_fill => [200, 200]
  end

  version :small do
    process :resize_to_fill => [86, 49]
  end

  version :file_small do 
    process :resize_to_fill => [123, 90]
  end 

  def extension_white_list
    %w(jpg jpeg gif png bmp jf)
  end

end
