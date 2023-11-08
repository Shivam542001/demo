require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  # let(:user) {User.create(name: "test", email: "test@gmail.com", password: "shukla", password_confirmation: "shukla", role: 1)}

  describe 'POST #create' do
    it 'create new product' do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      sign_in(user)
      expect do
        post :create, params: {product: {name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id } } 
      end.to change(Product, :count).by(1)
    end
    it 'does not create new product' do
      user = User.create(email: 'test@example.com', password: 'password')
      sign_in(user)
      expect do
        post :create, params: {product: {name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id } } 
      end.to change(Product, :count).by(0)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      sign_in(user)
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id)
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end
  end

  describe "GET #index" do
    it "renders the index template" do
    get :index
    expect(response).to render_template("index")
    end
  end

  describe "#edit" do
    it "displays the edit product form" do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id)
      sign_in(user)
      get :edit, params: { id: product.id }
      expect(response).to be_successful 
      expect(response).to render_template("edit")
    end
  end

  describe "#update" do
    it "updates the product" do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id)
      sign_in(user)
      patch :update, params: {product: {name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 456, quantity: 4, user_id: user.id}, id:product.id } 
    expect(response).to be_redirect
    end
    it "updates the product" do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id)
      sign_in(user)
      patch :update, params: {product: {name: "Nike Shoes", description: "big length shoes", category:"TEST", price: "hello", quantity: 4, user_id: user.id}, id:product.id } 
    expect(response).not_to be_redirect
    end
  end

  describe 'GET #category' do
    it 'renders the category template' do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      sign_in(user)
      product = Product.create(name: "Nike Shoes", description: "big length shoes", category:"TEST", price: 123, quantity: 4, user_id: user.id)
      get :category, params: { category: product.category }
      expect(response).to render_template("category")
    end
  end

  describe "#new" do
    it "displays new product form" do
      user = User.create(email: 'test@example.com', password: 'password', role: 1)
      sign_in(user)
      get :new
      expect(response).to be_successful 
      expect(response).to render_template("new")
    end
  end
end 
