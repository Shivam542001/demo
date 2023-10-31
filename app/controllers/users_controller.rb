class UsersController < ApplicationController

  def home 
    @products = Product.all

    if user_signed_in?
      if current_user.admin?        
        render "users/home_admin"
        # redirect_to users_url
      else
        # render "users/home_user"
        # render "products/index"
        redirect_to products_path
      end

      # render "products/index"
    else
      redirect_to new_user_session, error: "Please Login Before"
    end
  end

end
