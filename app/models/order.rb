class Order < ApplicationRecord
  has_many :cart_products
end
