require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:user)  {User.create(email: 'test@example.com', password: 'password')}
  let(:admin)  {User.create(email: 'admin@example.com', password: 'password', role:1)}
  let(:product)  {Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id)}

  
  describe "GET #index" do
    it "renders index in json" do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      get :index
      expect(response).to have_http_status(:ok) 
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id)

      get :show, params: { id: product.id }
      expect(response).to have_http_status(:ok) 
    end
    it 'returns a successful response' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      get :show, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #category' do
    it 'renders the category template' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(user.id)}"
      get :category, params: { category: product.category }
      expect(response).to have_http_status(:ok) 
    end
  end

  describe 'POST #create' do
    it 'create new product' do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      expect do
        post :create, params: {product: {name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id } } 
      end.to change(Product, :count).by(1)
    end
  end

  describe "#update" do
    it "updates the product" do
      request.headers['Authorization'] = "Bearer #{AuthenticationService.encode_token(admin.id)}"
      patch :update, params: {product: {name: "Nike puma Shoes", description: "big length shoes", category:"TEST", price: 456, quantity: 4, user_id: admin.id}, id:product.id } 
      expect(response).to have_http_status(:ok) 
    end
  end

end
