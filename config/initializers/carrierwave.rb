# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

module CarrierWave
  module RMagick
    def resize_to_fill_modified(width, height, gravity = ::Magick::CenterGravity)
      manipulate! do |img|
        img.crop_resized!(width, height, gravity) unless (img.columns <= width && img.rows <= height)
        img = yield(img) if block_given?
        img
      end
    end

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end
  end
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['S3_ACCESS_KEY'],
    aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region:                'us-west-1',
    path_style: true
  }
  config.fog_directory = ENV['S3_BUCKET_NAME']

  if Rails.env.production?
    config.storage = :fog
  elsif Rails.env.development?
  	config.storage = :file
  else
    config.storage NullStorage
    config.enable_processing = false
  end
end
