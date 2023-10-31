class ProductsController < ApplicationController
  before_action :req_admin, only: [:new, :create, :edit]
  before_action :up_cateogry, only: :create
  before_action :set_category

  def index
    @products = Product.all
    @categories = Product.distinct.pluck(:category)
  end

  def show
    @product = Product.find(params[:id])
    @cart = @current_cart
  end

  def category
    @products = Product.where(category: params[:category])
    # @categories = Product.distinct.pluck(:category)
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
    params.require(:product).permit(:name, :description, :price, :quantity, :image, :category)
  end

  def req_admin
    unless current_user.admin?
      flash[:error] = "You are not admin"
      redirect_to products_path
    end
  end
  
  def up_cateogry
    product_params[:category].upcase!
    # puts product_params[:category]
    # puts "---------------------------------------------"
  end
  
  def set_category
    @categories = Product.distinct.pluck(:category)
  end
end
