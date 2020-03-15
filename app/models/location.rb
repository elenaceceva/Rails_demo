class Location < ApplicationRecord
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :city, length: {maximum: 120}, presence: true
  validates :country, length: {maximum: 120}, presence: true
  has_many :users
  has_many :posts
  acts_as_mappable

end
