class PrintRequest < ActiveRecord::Base
  belongs_to :medium
  belongs_to :user

  has_enumeration_for :status, with: PrintRequestStatus, create_helpers: true
end
