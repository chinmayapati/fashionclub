class Address < ActiveRecord::Base

  validates_presence_of :first_name, :last_name, :phone, :city, :zipcode, :country
  validates :phone, uniqueness: true

end
