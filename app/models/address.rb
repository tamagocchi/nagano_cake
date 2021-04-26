class Address < ApplicationRecord
  belongs_to :customer

   def order_detail
    self.postcode + self.destination + self.delivery_name
  end

end
