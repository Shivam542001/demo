class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def cart_price
    sum=0
    self.cart_products.each{|cp| sum+=cp.total_price}
    sum
  end

end
