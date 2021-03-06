class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable

  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :projects, foreign_key: 'owner_id', dependent: :destroy

  has_enumeration_for :role, with: UserRole, required: true, create_scopes: true,
                             create_helpers: true

  belongs_to :address
  accepts_nested_attributes_for :address
end
