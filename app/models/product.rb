class Product < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :price, numericality: { only_integer: true }

  
  
  belongs_to :user
  has_one_attached :image, dependent: :destroy
end
