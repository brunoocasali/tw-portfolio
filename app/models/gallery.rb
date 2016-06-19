class Gallery < ActiveRecord::Base
  belongs_to :project

  has_many :media, dependent: :delete_all

  validates :name, presence: true

  has_enumeration_for :kind, with: GalleryKind, required: true

  def cover
    media.where(cover: true).first
  end
end
