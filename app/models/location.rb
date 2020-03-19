class Location < ApplicationRecord

  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :city, length: {maximum: 120}, presence: true
  validates :country, length: {maximum: 120}, presence: true
  has_many :users
  has_many :posts
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude


end
