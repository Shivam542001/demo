class PagesController < ApplicationController
  def home

    # @users = User.all 

    if user_signed_in?
      if current_user.admin?        
        render "pages/abc"
        # redirect_to users_url
      else
        render "pages/def"
      end
    end

    # def after_sign_in_path_for(resource)
    #   if current_user.admin?
    #     user_path(current_user) # your path
    # end
  end
end
