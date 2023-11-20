class Api::V1::CartProductsController < ApiController
  protect_from_forgery with: :null_session
  before_action :authenticate_request

  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
    debugger
    if current_cart.products.include?(chosen_product)
      cart_product = current_cart.cart_products.find_by(:product_id => chosen_product.id)
      cart_product.quantity += 1
    else
      cart_product = CartProduct.new
      cart_product.cart = current_cart
      cart_product.product = chosen_product
    end
    
    if cart_product.save
      render json: current_cart.cart_products
    else
      render json: { error: 'Product not added to cart' }, status: :not_found
    end
  end

  def add_quantity
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      if cart_product.product.quantity>cart_product.quantity
        cart_product.quantity += 1
        cart_product.save
        render json: cart_product
      else
        render json: { error: 'Product limit reached ' }, status: :method_not_allowed
      end
    else
      render json: { error: 'Product Not Exist In Cart ' }, status: :method_not_allowed
    end      
  end
  
  def reduce_quantity
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      if cart_product.quantity > 1
        cart_product.quantity -= 1
        cart_product.save
        render json: cart_product
      else
        cart_product.destroy
        render json: { message: 'Product Removed ' }, status: :ok
      end
    else
      render json: { error: 'Product Not Exist In Cart ' }, status: :method_not_allowed
    end  
  end

  def destroy
    cart_product = CartProduct.find(params[:id])
    if cart_product && cart_product.destroy
      render json: { message: 'Product Removed ' }, status: :ok
    else
      render json: { error: 'Something Wrong'}, status: :ok
    end
  end  

end
