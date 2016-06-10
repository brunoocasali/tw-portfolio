class Address < ActiveRecord::Base
  validates :zipcode, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :nick, presence: true

  def to_s
    "#{street}, #{city} - #{state}. #{reference}"
  end
end
