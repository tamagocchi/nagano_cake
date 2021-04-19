class Public::CartProductsController < ApplicationController

  def index
    @cart_products = CartProduct.all
  end

  def create
    @cart_product = CartProduct.new(cart_product_params)
    @cart_product.save
    redirect_to cart_products_path
  end

  def update
    @cart_product = CartProduct.find(params[:cart_product][:id])
    @cart_product.update(product_quantity: params[:cart_product][:product_quantity])
    redirect_to cart_products_path
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path
  end

  def destroy_all
    current_customer.cart_products.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:product_quantity,:customer_id,:product_id)
  end

end
