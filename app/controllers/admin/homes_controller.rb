class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    path = Rails.application.routes.recognize_path(request.referer)

    if path[:controller]=="admin/customers" && path[:action] == "show"
      @orders = Order.where(customer_id: path[:id])
    else
      @orders = Order.all
    end
  end
end
