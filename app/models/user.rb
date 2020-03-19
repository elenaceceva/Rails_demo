class User < ApplicationRecord
  attr_accessor :location_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  belongs_to :location, optional: true
  validates :email, length: { maximum: 120 }
  validates :nickname, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :firstname, length: { maximum: 40}
  validates :lastname, length: { maximum: 40}
  before_save :assign_location

  def assign_location
    location = Location.find_or_create_by(country: location_attributes[:country],
                                          city: location_attributes[:city],
                                          longitude: location_attributes[:longitude],
                                          latitude: location_attributes[:latitude])


    self.location_id = location.id
  end


end
