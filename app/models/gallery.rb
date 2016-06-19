class Gallery < ActiveRecord::Base
  belongs_to :project

  has_many :media, dependent: :delete_all

  validates :name, presence: true

  has_enumeration_for :kind, with: GalleryKind, required: true

  def cover
    if media.size > 0
      media.where(cover: true).first || media.public_media.first || media.first
    end
  end
end
