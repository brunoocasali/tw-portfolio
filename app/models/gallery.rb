class Gallery < ActiveRecord::Base
  belongs_to :project
  belongs_to :cover, class_name: 'Medium', foreign_key: :medium_id

  has_many :media, dependent: :destroy
  has_many :print_requests, dependent: :delete_all

  validates :name, presence: true

  has_enumeration_for :kind, with: GalleryKind, required: true
end
