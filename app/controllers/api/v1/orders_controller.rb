class Api::V1::OrdersController < ApiController
  protect_from_forgery with: :null_session
  before_action :authenticate_request


  def index
    if current_user.admin?
      orders = Order.all
    else
      orders = current_user.orders
    end
    render json: orders, status: :ok
  end

  def show
    order = Order.find_by(id: params[:id])
    if order
      render json: order, status: :ok
    else
      render json: { error: 'Order Not Found' }, status: :not_found
    end
  end

end
