require 'rails_helper'
RSpec.describe Api::V1::OrdersController, type: :controller do
  let(:user)  {User.create(email: 'test@example.com', password: 'password')}
  let(:admin)  {User.create(email: 'admin@example.com', password: 'password', role:1)}


  describe 'GET #show' do
    it 'returns a successful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      order = Order.create(name: "heeela", address: "patnipura indore", phone: "1122334455", order_amount:100, order_on:Time.now.to_date, user_id:user.id) 
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:ok) 
    end
    it 'returns a unsuccessful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      get :show, params: { id: -1 }
      expect(response).to have_http_status(:not_found) 
    end
  end

  describe "GET #index" do
    it "renders the index template as admin" do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      get :index
      expect(response).to have_http_status(:ok) 
    end
    it "renders the index template as User" do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      get :index
      expect(response).to have_http_status(:ok) 
    end
  end  
end