class Public::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = User.cart_products
  end

  def new
  end

  def confirm
    @order = User.order
  end

  def create
    @order = Order.new
    @order.save
    redirect_to orders_complete_path
  end

  def complete
  end


end
