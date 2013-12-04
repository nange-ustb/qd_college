# -*- encoding : utf-8 -*-

class UserHeaderUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  version :small do
    process :resize_to_fill => [200, 200]
  end

  version :mini do
    process :resize_to_fill => [100, 100]
  end

  version :large do
    process :resize_to_fill => [500, 500]
  end

  def store_dir
    "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_white_list
    model.remote_link_url.present? ? nil : %w(jpg jpeg gif png)
  end
end
