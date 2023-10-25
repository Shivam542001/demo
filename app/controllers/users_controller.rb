class UsersController < ApplicationController
  def index 

    @users = User.all
  
  
  end


  def home 
    @products = Product.all

    if user_signed_in?
      if current_user.admin?        
        render "users/home_admin"
        # redirect_to users_url
      else
        # render "users/home_user"
        render "products/index"
      end
    end

  end

end
