class ApplicationController < ActionController::Base

  before_action :set_category
  
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  
  
  
  before_action :current_cart 
  
  def current_cart
    if user_signed_in? && !current_user.admin?
      if session[:cart_id]
        @current_cart ||= Cart.find(session[:cart_id])
      end
      if session[:cart_id].nil?
        @current_cart = Cart.create!
        session[:cart_id] = @current_cart.id
      end
      @current_cart
    end
  end 

  protected
  def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end
  def set_category
    @categories = Product.distinct.pluck(:category)
  end

end
