class Public::SessionsController < ApplicationController

  before_action :reject_user, only: [:create]

  protected

  # ======= 会員ステータスが退会の場合ログインを無効化 =======
  def reject_user
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:error] = "退会済みです"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "必須項目を入力してください"
    end
  end

end
