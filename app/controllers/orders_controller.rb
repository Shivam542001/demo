class OrdersController < ApplicationController
  before_action :require_products, only: [:new, :create]



  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
       
      current_cart.cart_products.each do |cart_product|
         @order.order_items.create!(         
            product_id: cart_product.product_id,
            quantity: cart_product.quantity 
         )
         @product=cart_product.product
         @product.quantity-=cart_product.quantity
         @product.save
         cart_product.destroy
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id]=nil

      redirect_to @order, notice: 'Order was successfully created.'
   else
       redirect_to root_path, notice: 'Something went wrong saving the order.'
   end 
  end

  private
    def order_params
      params.require(:order).permit(:name, :address, :phone).merge(order_amount: current_cart.cart_price)
   end

   def require_products
    if current_cart.cart_products.empty?
      flash[:error] = "Cart Cannot be Empty"
      redirect_to cart_path(@current_cart)
    end
  end


end
