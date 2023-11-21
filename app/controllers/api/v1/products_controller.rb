class Api::V1::ProductsController < ApiController
  before_action :up_cateogry, only: :create
  protect_from_forgery with: :null_session
  before_action :authenticate_request
  before_action :req_admin, only: [:create, :update]


  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: :ok
    else
      render json: { error: 'Product Not Found' }, status: :not_found
    end
  end

  def category
    products = Product.where(category: params[:category])
    render json: products, status: :ok
  end

  def create
    user = current_user
    product = user.products.create(product_params)
    if product
      render json: product, status: :ok
    else
      render json: { error: 'Product Not Created' }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :image, :category)
  end

  def req_admin
    if user_signed_in?
      if !current_user.admin?
        render json: { error: 'Required Admin' }, status: :unauthorized
      end
    end
  end
  
  def up_cateogry
    product_params[:category].upcase!
  end
end
