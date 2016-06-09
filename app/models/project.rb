class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  validates :code, :name, presence: true
  has_enumeration_for :status, with: ProjectStatus, required: true,
                               create_helpers: true
end
