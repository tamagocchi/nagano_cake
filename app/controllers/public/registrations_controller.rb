class Public::RegistrationsController < ApplicationController

  def after_sign_up_path_for(resource)
    customer_show_path(current_customer)
  end

end
