class Contact < ActiveRecord::Base
  has_enumeration_for :status, with: ContactStatus, required: true,
                               create_helpers: true, create_scopes: true

  validates :name, presence: true
  validates :email, presence: true, format: { with: /@/ }
  validates :message, presence: true

  def self.news?
    unread.any?
  end
end
