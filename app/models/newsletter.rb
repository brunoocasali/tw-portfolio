class Newsletter < ActiveRecord::Base
  belongs_to :project

  validates :project, presence: true

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  paginates_per 50
end
