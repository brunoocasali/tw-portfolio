class Address < ActiveRecord::Base

  def to_s
    "#{street}, #{city} - #{state}. #{reference}"
  end
end
