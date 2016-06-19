class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def store_dir
    "uploads/#{Rails.env.underscore}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

    'no_photo.jpg'
  end

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fit: [350, 150]
  end

  version :large do
    process quality: 80
    process resize_to_fit: [1024, 728]
  end

  version :thumb do
    process resize_to_fit: [130, 110]
  end

  version :watermarked do
    process :watermark
  end

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/utils/watermark.png").first
      img = img.composite(logo, Magick::SouthEastGravity, 15, 5, Magick::OverCompositeOp)
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
