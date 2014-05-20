class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :detail do
    process resize_to_fit: [400, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
