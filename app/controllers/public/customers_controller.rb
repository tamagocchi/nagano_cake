class Public::CustomersController < ApplicationController
    def show
        @customer = current_customer
    end

    def edit
        @customer = current_customer
    end

    def update
  	    @customer = Customer.find(params[:id])
  	    @customer.update(customer_params)
    end



end
