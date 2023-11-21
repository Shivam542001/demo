class Product < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :price, numericality: { only_integer: true }
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  # def self.ransackable_attributes(auth_object = nil)
  #   %w(name age)
  # end

end
