class Api::V1::UsersController < ApiController
  protect_from_forgery with: :null_session

  def login
    user = AuthenticationService.authenticate(params[:email], params[:password])

    if user
      token = AuthenticationService.encode_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def create

    @user = User.new(user_params)
  
    if @user.save
      
      token = AuthenticationService.encode_token(@user.id)
      render json: { token: token }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
