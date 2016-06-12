class PrintRequest < ActiveRecord::Base
  belongs_to :medium
  belongs_to :requestor, class_name: 'User', foreign_key: :user_id

  validates :size, presence: true, unless: :size_other?
  validates :size_other, presence: true, unless: :size?

  validates :requestor, presence: true

  has_enumeration_for :status, with: PrintRequestStatus,
                               create_helpers: true, create_scopes: true
  has_enumeration_for :size, with: PrintRequestSize, create_helpers: true

  def print_size
    size_humanize || size_other
  end
end
