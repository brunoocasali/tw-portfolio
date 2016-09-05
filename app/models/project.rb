class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  has_many :newsletters, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :media, through: :galleries
  has_many :print_requests, through: :media

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true, allowed_route: true,
                   format: {
                      with: /\A[a-zA-Z0-9_-]+\Z/,
                      message: 'Não é possivel usar caracteres especiais como pontos(.) e barras (/)'
                   }

  has_enumeration_for :status, with: ProjectStatus, required: true, create_helpers: true, create_scopes: true

  before_save { code.downcase! }
end
