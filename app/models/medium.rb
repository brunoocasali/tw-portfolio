class Medium < ActiveRecord::Base
  belongs_to :gallery
  has_many :print_requests

  mount_uploader :filename, PhotoUploader

  validates :filename, presence: true

  before_save :update_asset_attributes
  delegate :project, to: :gallery
  delegate :owner, to: :project

  scope :public_media, -> { where(show: true) }

  private

  def update_asset_attributes
    if filename.present? && filename_changed?
      self.file_size = filename.file.size
    end
  end
end
