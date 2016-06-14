class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  has_many :newsletters
  has_many :sessions
  has_many :galleries
  has_many :media, through: :galleries
  has_many :print_requests, through: :media

  validates :code, :name, presence: true, format: { with: /\A[a-zA-Z0-9_]{2,30}\Z/ }

  has_enumeration_for :status, with: ProjectStatus, required: true, create_helpers: true
end
