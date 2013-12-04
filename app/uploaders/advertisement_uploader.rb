# -*- encoding : utf-8 -*-

class AdvertisementUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  
  def store_dir
    "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [275, 150]
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp jf)
  end

end
