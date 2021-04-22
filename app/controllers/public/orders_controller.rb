class Public::OrdersController < ApplicationController

  def index
    @order_products = current_customer.orders
  end

  def show
    @orders = Order.all
    @order_products = current_customer.orders

    @sub_total = 0
    @order_products.shipping_fee = 800

    @cart_products = current_customer.cart_products
    @cart_products.each do |cart|
    @sub_total += cart.product.price * cart.product_quantity
    end

  end

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm

    @cart_products = current_customer.cart_products
    @sub_total = 0

    @cart_products.each do |cart|
    @sub_total += cart.product.price * cart.product_quantity
    end

    @order = Order.new
    @order.customer_id = current_customer.id
    @order.order_status = 0
    @order.shipping_fee = 800
    @order.payment_method = params[:order][:payment_method]

    @order_address = params[:order][:address_option]

    if @order_address == "1"

     @order.postcode = current_customer.postcode
     @order.destination = current_customer.address
     @order.delivery_name = current_customer.last_name + current_customer.first_name

    elsif @order_address == "2"

     @address = Address.find(params[:order][:address_id])
     @order.postcode =  @address.postcode
     @order.destination =  @address.destination
     @order.delivery_name = @address.delivery_name

    elsif @order_address == "3"

     @order.postcode = params[:order][:postcode]
     @order.destination = params[:order][:destination]
     @order.delivery_name = params[:order][:delivery_name]

    end

  end

  def create

    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postcode = current_customer.postcode
    @order.destination = current_customer.address
    @order.delivery_name = current_customer.last_name + current_customer.first_name
    @order.total_price = current_customer.cart_products, + 800
    @order.save


    redirect_to orders_complete_path
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :total_price, :payment_method, :destination, :delivery_name)
  end

end