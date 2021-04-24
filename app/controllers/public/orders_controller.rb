class Public::OrdersController < ApplicationController

  def index
    @order_products = current_customer.orders
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details

    @sub_total = 0
    @order_details.each do |order_detail|
    @sub_total += order_detail.product.price * order_detail.product_quantity
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
    @sub_total += cart.product.tax_included_price.floor * cart.product_quantity
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

    order_details_maker(@order)

    redirect_to orders_complete_path
  end

  def complete
  end

  private

  def order_details_maker(order)

    cart_products = current_customer.cart_products

    cart_products.each do |cart_product|
      order_detail = OrderDetail.new

      order_detail.product_id = cart_product.product_id
      order_detail.order_id = order.id
      order_detail.product_quantity = cart_product.product_quantity
      order_detail.making_status = 0
      order_detail.price = cart_product.product.price
      order_detail.save
    end

    cart_products.destroy_all

  end

  def order_params
    params.require(:order).permit(:postcode, :total_price, :payment_method, :destination, :delivery_name)
  end

end