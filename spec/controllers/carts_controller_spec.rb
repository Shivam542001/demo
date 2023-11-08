require 'rails_helper'
RSpec.describe CartsController, type: :controller do
  
  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(email: 'test@example.com', password: 'password', role: 0)
      sign_in(user)
      cart = Cart.create
      get :show, params: { id: cart.id }
      expect(response).to be_successful
    end
    it 'returns a successful response' do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      sign_in(user)
      cart = Cart.create
      get :show, params: { id: cart.id }
      expect(response).not_to be_successful
    end
  end

end