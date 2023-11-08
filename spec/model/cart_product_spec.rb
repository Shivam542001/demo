require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  let(:cart) {Cart.create}
  let(:user) {User.create(name: "test", email: "test@gmail.com", password: "shukla", password_confirmation: "shukla", role: 1)}
  let(:product) {Product.create(name: "Nike Shoes", description: "big length shoes", price: 122, user_id: user.id)}

  it "is valid with a product_id, and cart_id" do
    cart_product = CartProduct.new(product_id: product.id, cart_id: cart.id)
    expect(cart_product).to be_valid
  end
end