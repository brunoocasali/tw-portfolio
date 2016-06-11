class Medium < ActiveRecord::Base
  belongs_to :gallery

  mount_uploader :filename, PhotoUploader

  validates :filename, presence: true

  before_save :update_asset_attributes

  private

  def update_asset_attributes
    if filename.present? && filename_changed?
      self.file_size = filename.file.size
    end
  end
end
