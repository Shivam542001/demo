require 'rails_helper'


RSpec.describe Order, type: :model do
  it "is valid with a name, address and phone" do
    order = Order.new(name: "hiiiiii", address: "rfalfhdshflsdyhfei", phone: "9977889977")
    expect(order).to be_valid
  end
end