class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {クレジットカード:1, 銀行振込:2}

   def order_detail
    self.postcode + self.destination + self.delivery_name
  end

end