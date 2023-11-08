require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid user" do
    user = User.new(name: "test", email: "test@gmail.com", password: "shukla", password_confirmation: "shukla")
    expect(user).to be_valid
  end
end

