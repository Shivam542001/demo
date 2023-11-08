class CartProductsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    # debugger
    chosen_product = Product.find(params[:product_id])
    
    current_cart = @current_cart
  
    if current_cart.products.include?(chosen_product)
      @cart_product = current_cart.cart_products.find_by(:product_id => chosen_product.id)
      @cart_product.quantity += 1
    else
      @cart_product = CartProduct.new
      @cart_product.cart = current_cart
      @cart_product.product = chosen_product
    end
  
    @cart_product.save
    redirect_to cart_path(current_cart)
  end

  def add_quantity
    @cart_product = CartProduct.find(params[:id])
    if @cart_product.product.quantity>@cart_product.quantity
      @cart_product.quantity += 1
      @cart_product.save
    else
      flash.alert = "Maximum Limit Reached"
    end

    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    @cart_product = CartProduct.find(params[:id])
    if @cart_product.quantity > 1
      @cart_product.quantity -= 1
      @cart_product.save
    else
      @cart_product.destroy
    end
      redirect_to cart_path(@current_cart)
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_path(@current_cart)
  end  

end
