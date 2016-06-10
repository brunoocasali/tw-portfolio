class Contact < ActiveRecord::Base
  has_enumeration_for :status, with: ContactStatus, required: true,
                               create_helpers: true, create_scopes: true

  def self.news?
    unread.any?
  end
end
