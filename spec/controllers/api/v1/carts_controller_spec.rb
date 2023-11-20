require 'rails_helper'
RSpec.describe Api::V1::CartsController, type: :controller do
  let(:user)  {User.create(email: 'test@example.com', password: 'password')}
  let(:admin)  {User.create(email: 'admin@example.com', password: 'password', role:1)}

  describe 'GET #show' do
    it 'returns a successful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      cart = Cart.create
      get :show, params: { id: cart.id }
      expect(response).to have_http_status(:ok) 
    end
    it 'returns a unsuccessful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found) 
    end
    it 'returns a unsuccessful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:unauthorized) 
    end
  end

end