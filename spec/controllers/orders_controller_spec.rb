require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  let(:current_cart)  {Cart.create}
  let(:user)  {User.create(email: 'test@example.com', password: 'password', role: 0)}
  let(:admin)  {User.create(email: 'admin@example.com', password: 'password', role: 1)}

  describe 'POST #create' do
    it 'create new order' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      product = Product.create!(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id)
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:1)
      expect do
        post :create, params: {order: {name: "heeela", address: "patnipura indore", phone: "1122334455", order_amount:100, order_on:Time.now.to_date, user_id:user.id} } 
      end.to change(Order, :count).by(1)
    end
    it 'does not create new order' do
      sign_in(user)
      session[:cart_id] = current_cart.id
      expect do
        post :create, params: {order: {name: "heeela", address: "patnipura indore", phone: "1122334455", order_amount:100, order_on:Time.now.to_date, user_id:user.id} } 
      end.to change(Order, :count).by(0)
    end
    it 'does not create new order' do
    sign_in(user)
      session[:cart_id] = current_cart.id
      product = Product.create!(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: admin.id)
      cp = CartProduct.create!(product_id: product.id, cart_id: current_cart.id, quantity:1)
      expect do
        post :create, params: {order: {address: "patnipura indore", phone: "1122334455", order_amount:100, order_on:Time.now.to_date, user_id:user.id} } 
      end.to change(Order, :count).by(0)
    end
  end


  describe 'GET #show' do
    it 'returns a successful response' do
      sign_in(user)
      order = Order.create(name: "heeela", address: "patnipura indore", phone: "1122334455", order_amount:100, order_on:Time.now.to_date, user_id:user.id) 
      get :show, params: { id: order.id }
      expect(response).to be_successful
    end
  end

  describe "GET #index" do
    it "renders the index template as admin" do
      sign_in(admin)
      get :index
      expect(response).to render_template("index")
    end
    it "renders the index template as User" do
      sign_in(user)
      get :index
      expect(response).to render_template("index")
    end
  end

  # describe "#new" do
  #   it "displays new order form" do
  #     user = User.create(email: 'test@example.com', password: 'password', role: 0)
  #     sign_in(user)
  #     get :new
  #     expect(response).to be_successful 
  #     expect(response).to render_template("new")
  #   end
  # end

end