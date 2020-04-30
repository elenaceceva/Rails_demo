class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attr_accessor :location_attributes
  attr_accessor :tag_names
  attr_accessor :picture_attributes

  validates :title, length: { maximum: 120 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true

  before_save :assign_location, :assign_tags

  has_attached_file :picture, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def assign_location
    if location_attributes.present?
    location = Location.find_or_create_by(country: location_attributes[:country],
                                          city: location_attributes[:city],
                                          longitude: location_attributes[:longitude],
                                          latitude: location_attributes[:latitude])
    self.location_id = location.id
    end
  end

  def assign_tags
    tag_names.split(',').each do |name|
      tag = Tag.find_or_create_by(name: name.strip)
      tags << tag unless tags.exists?(tag.id)
    end
    delete_tags
  end

  def delete_tags
    names = tag_names.split(',').map { |n| n.strip }
    tags.each do |tag|
      tags.destroy(tag) unless names.include?(tag.name)
    end
  end
end
