class Gallery < ActiveRecord::Base
  belongs_to :project

  has_many :media, dependent: :destroy

  validates :name, presence: true
  validates :download_link, url: { allow_blank: true }

  has_enumeration_for :kind, with: GalleryKind, required: true

  def cover
    media.where(cover: true).first
  end
end
