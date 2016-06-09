class Session < ActiveRecord::Base
  belongs_to :project
  belongs_to :address

  validates :address, presence: true

  accepts_nested_attributes_for :address

  has_enumeration_for :status, with: SessionStatus, required: true, create_helpers: true
end
