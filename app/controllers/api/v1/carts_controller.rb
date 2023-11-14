class Api::V1::CartsController < ApiController
  protect_from_forgery with: :null_session
  before_action :authenticate_request
  before_action :req_user


  def show
    @cart = Cart.find_by(id: params[:id])
    if @cart
      render json: @cart.cart_products
    else
      render json: { error: 'Cart Not Found' }, status: :not_found
    end
  end

  private
    def req_user
      if !user_signed_in? || current_user.admin?
        render json: { error: 'Required User' }, status: :unauthorized
      end
    end
end
