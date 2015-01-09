class PostImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  version :posts do
    process resize_to_fill: [400, 400]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
