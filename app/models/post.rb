class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attr_accessor :location_attributes
  attr_accessor :tag_attributes
  attr_accessor :picture_attributes

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" },
                    :storage => ‘s3’,
                    :s3_region => ENV[us-east-2]
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :title, length: { maximum: 120 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true

  before_save :assign_location


  def assign_location
    if location_attributes.present?
    location = Location.find_or_create_by(country: location_attributes[:country],
                                          city: location_attributes[:city],
                                          longitude: location_attributes[:longitude],
                                          latitude: location_attributes[:latitude])
    self.location_id = location.id
    end
  end

  def assign_tag
      self.tags = Tag.find_or_create_by(name: tag_attributes[:name])
    end
end
