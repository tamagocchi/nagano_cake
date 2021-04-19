class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy

  attachment :image

  def is_active_to_string
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end

  def tax_included_price
    tax_rate = 1.08
    price * tax_rate
  end

end
