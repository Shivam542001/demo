class ProductsController < ApplicationController
  before_action :req_admin, only: [:new, :create, :edit]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart = @current_cart
  end

  def new
    @product = Product.new
  end

  def create
    @user = current_user

    @product = @user.products.create(product_params)
    redirect_to @product
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end

  def req_admin
    unless current_user.admin?
      flash[:error] = "You are not admin"
      redirect_to products_path
    end
  end

end
