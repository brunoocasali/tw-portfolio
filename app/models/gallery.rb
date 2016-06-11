class Gallery < ActiveRecord::Base
  belongs_to :session
  belongs_to :cover, class_name: 'Medium', foreign_key: :medium_id

  has_many :media, dependent: :destroy

  validates :name, presence: true

  has_enumeration_for :kind, with: GalleryKind, required: true
end
