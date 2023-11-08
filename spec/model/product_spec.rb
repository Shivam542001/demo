require 'rails_helper'
RSpec.describe Product, type: :model do
  let(:user) {User.create(name: "test", email: "test@gmail.com", password: "shukla", password_confirmation: "shukla", role: 1)}

  it "is valid with a name, description, price, quantity and category" do
    product = Product.new(name: "Nike Shoes", description: "big length shoes", price: 122, user_id: user.id)
    expect(product).to be_valid
  end
end

