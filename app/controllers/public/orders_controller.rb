class Public::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.all
  end

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm

    @orders = Order.all

    @order_address = params[:order][:address_option]

    @order = Order.new
    @order.customer_id = current_customer.id
    @order.order_status = 0
    @order.shipping_fee = 800
    @order.payment_method = params[:order][:payment_method]

    if @order_address == "1"

     @order.postcode = current_customer.postcode
     @order.destination = current_customer.address
     @order.delivery_name = current_customer.name

    elsif @order_address == "2"

     @address = Address.find(params[:order][:address_id])
     @order.postcode =  @address.postcode
     @order.destination =  @address.destination
     @order.delivery_name = @address.delivery_name

    elsif @order_address == "3"

    end

  end

  def create
    @product = Product.find(params[:product_id])
    @order = @product.order.new(order_params)
    @order.save
    redirect_to orders_complete_path
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:address_id, :postcode, :total_price, :payment_method, :delivery_name)
  end

end