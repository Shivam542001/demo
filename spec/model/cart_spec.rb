require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "is valid " do
    cart = Cart.new
    expect(cart).to be_valid
  end
end