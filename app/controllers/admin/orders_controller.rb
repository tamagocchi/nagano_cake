class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])

    @sub_total = 0
    @order.order_details.each do |order_detail|
    @sub_total += order_detail.product.price * order_detail.product_quantity
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)

    if @order.order_status == "入金確認"

      @order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)

    end

    end


  end

  def order_params
    params.require(:order).permit(:postcode, :total_price, :payment_method, :destination, :delivery_name, :order_status, :making_status)
  end

end
