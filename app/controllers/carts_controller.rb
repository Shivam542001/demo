class CartsController < ApplicationController
  before_action :req_user

  def show
    # @cart = @current_cart
    @cart = Cart.find(params[:id])
  end

  private
    def req_user
      if !user_signed_in? || current_user.admin?
        redirect_to root_path
      end
    end
end
