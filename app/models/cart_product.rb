class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  # belongs_to :order


  def total_price
    self.product.price*self.quantity
  end

  # def add
  #   if self.product.quantity>self.quantity
  #     self.quantity += 1
  #   else
  #     self.quantity
  #   end
  # end

end
