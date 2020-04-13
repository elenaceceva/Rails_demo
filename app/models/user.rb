class User < ApplicationRecord
  belongs_to :location, optional: true
  has_many :posts

  attr_accessor :location_attributes
  attr_accessor :picture_attributes

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :email, length: { maximum: 120 }
  validates :nickname, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :firstname, length: { maximum: 40}

  before_save :assign_location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable



  def assign_location
    if location_attributes.present?
    location = Location.find_or_create_by(country: location_attributes[:country],
                                          city: location_attributes[:city],
                                          longitude: location_attributes[:longitude],
                                          latitude: location_attributes[:latitude])
    self.location_id = location.id
   end
  end
end