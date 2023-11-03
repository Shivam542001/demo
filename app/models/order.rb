class Order < ApplicationRecord
  validates :name, :address, :phone, presence: true
  validates :phone, format: { with: /\A\d{10}\z/ }, allow_blank: true

  
  has_many :order_items
  has_many :products, through: :order_items

end
