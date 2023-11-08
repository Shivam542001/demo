require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order)  {Order.create(name: "hiiiiii", address: "rfalfhdshflsdyhfei", phone: "9977889977")}
  let(:user) {User.create(name: "test", email: "test@gmail.com", password: "shukla", password_confirmation: "shukla", role: 1)}
  let(:product) {Product.create(name: "Nike Shoes", description: "big length shoes", price: 122, user_id: user.id)}

  it "is valid with a order_id, and prodcut_id" do
    order_item = OrderItem.new(product_id: product.id, order_id: order.id)
    expect(order_item).to be_valid
  end
end