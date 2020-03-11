class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  belongs_to :location
  validates :email, length: { maximum: 120 }, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :firstname, length: { maximum: 40}
  validates :lastname, length: { maximum: 40}

end
