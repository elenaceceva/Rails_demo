class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  validates :title, length: { maximum: 120 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true

  accepts_nested_attributes_for :location
end
