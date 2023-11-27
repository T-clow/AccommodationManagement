class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :reservations
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true

  def self.search_by_address(query)
    if query
      where("address LIKE :query", query: "%#{query}%")
    else
      all
    end
  end

  def self.search_by_name_or_description(query)
    if query
      where("name LIKE :query OR description LIKE :query", query: "%#{query}%")
    else
      all
    end
  end
end
