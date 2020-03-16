class User < ApplicationRecord
  attr_accessor :location_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  belongs_to :location, optional: true
  accepts_nested_attributes_for :location
  validates :email, length: { maximum: 120 }
  validates :nickname, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :firstname, length: { maximum: 40}
  validates :lastname, length: { maximum: 40}


end
