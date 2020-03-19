class Post < ApplicationRecord
  attr_accessor :location_attributes
  belongs_to :user
  belongs_to :location, optional: true
  validates :title, length: { maximum: 120 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true

  before_save :assign_location

  def assign_location
    location = Location.find_or_create_by(country: location_attributes[:country],
                                          city: location_attributes[:city],
                                          longitude: location_attributes[:longitude],
                                          latitude: location_attributes[:latitude])

    self.location_id = location.id
  end
end
