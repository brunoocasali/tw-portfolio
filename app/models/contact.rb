class Contact < ActiveRecord::Base
  has_enumeration_for :status, with: ContactStatus, required: true
end
