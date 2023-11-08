require 'rails_helper'
RSpec.describe CartProductsController, type: :controller do
  let(:current_cart)  {Cart.create}
  let(:user)  {User.create(email: 'test@example.com', password: 'password', role: 0)}
  let(:admin)  {User.create(email: 'admin@example.com', password: 'password', role: 1)}
  let(:product) {Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id)}


  describe 'POST #create' do
    it 'create new order' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      expect do
        post :create, params: {product_id: product.id} 
      end.to change(CartProduct, :count).by(1)
    end
  end

  describe 'GET #add' do
    it 'it adds the qunatity' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:1)
      initial_count = cp.quantity
      get :add_quantity, params: { id: cp.id }
      final_count = CartProduct.find(cp.id).quantity
      expect(final_count - initial_count).to eq(1)
    end
  end

  describe 'GET #reduce' do
    it 'it reduces the qunatity' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:3)
      initial_count = cp.quantity
      get :reduce_quantity, params: { id: cp.id }
      final_count = CartProduct.find(cp.id).quantity
      expect(initial_count-final_count).to eq(1)
    end
    it "removes item if one quantity in cart" do
      sign_in(user)
      session[:cart_id] = current_cart.id
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:1)
      get :reduce_quantity, params: { id: cp.id }
      expect(response).to have_http_status("302") 
    end
  end

  describe 'GET #destroy' do
    it 'removes item from show' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:4)
      delete :destroy, params: { id: cp.id }
      expect(response).to have_http_status("302") 
    end
  end
end