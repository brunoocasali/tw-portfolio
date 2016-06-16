class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{Rails.env.underscore}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fit: [350, 150]
  end

  version :thumb do
    process resize_to_fit: [130, 110]
  end

  process :watermark

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/utils/watermark.png").first
      img = img.composite(logo, Magick::SouthEastGravity, 15, 0, Magick::OverCompositeOp)
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
