class Api::V1::OrdersController < ApiController
  # before_action :require_products, only: [:new, :create]
  # before_action :req_user, only: [:create, :new]
  protect_from_forgery with: :null_session
  before_action :authenticate_request


  def index
    if current_user.admin?
      @orders = Order.all
    else
      @orders = current_user.orders
    end
    render json: @orders
  end

  def show
    @order = Order.find_by(id: params[:id])
    if @order
      render json: @order
    else
      render json: { error: 'Order Not Found' }, status: :not_found
    end
  end

  def new
    @order = Order.new
  end

  # def create
  #   debugger
  #   @order = Order.new(order_params)
  #   debugger
  #   if @order.save  
  #     current_cart.cart_products.each do |cart_product|
  #        @order.order_items.create!(product_id: cart_product.product_id, quantity: cart_product.quantity)
  #        @product=cart_product.product
  #        @product.quantity-=cart_product.quantity
  #        @product.save
  #        cart_product.destroy
  #     end
  #     Cart.destroy(session[:cart_id])
  #     session[:cart_id]=nil

  #     render json: @order
  #  else
  #     render json: { error: 'Something went wrong' }, status: :not_found
  #  end 
  # end

  # private
  #   def order_params
  #     params.require(:order).permit(:name, :address, :phone).merge(user_id:current_user.id, order_on:Time.now.to_date, order_amount: current_cart.cart_price)
  #  end

  #  def require_products
  #   if current_cart.cart_products.empty?
  #     flash[:error] = "Cart Cannot be Empty"
  #     redirect_to cart_path(@current_cart)
  #   end
  # end

  # def req_user
  #   if !user_signed_in? || current_user.admin?
  #     redirect_to root_path
  #   end
  # end

end
