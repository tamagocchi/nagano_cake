class Public::ProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
    @add_cart = CartProduct.new
  end

  def index
    @product_count = Product.count
    @products = Product.page(params[:page])
  end

end
