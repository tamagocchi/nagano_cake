class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:order_id])
    @order_detail.update(order_detail_params)

    @order = @order_detail.order

   if @order.order_details.where(making_status: '製作中').count > 0
      @order.order_status = '製作中'
      @order.save
   end

   if @order.order_details.where(making_status: '製作完了').count == @order.order_details.count
      @order.order_status = '発送準備中'
      @order.save
   end

    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :making_status, :product_quantity, :order_id)
  end

end
