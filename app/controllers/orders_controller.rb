class OrdersController < ApplicationController
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
            quantity:   cart_product.quantity 
         )
         cart_product.destroy
      end

      redirect_to @order, notice: 'Order was successfully created.'
   else
       redirect_to root_path, notice: 'Something went wrong saving the order.'
   end 
  end

  private
    def order_params
      params.require(:order).permit(:name, :address) 
   end


end
