class Client < User
  default_scope { client }

  validates :email, presence: true
  validates :name, presence: true

  before_validation :generate_password

  def generate_password
    if self.password.nil?
      self.password = Devise.friendly_token.first(12)
      self.password_confirmation = password
    end
  end
end
