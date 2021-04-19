class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy

  enum is_active: { inactive: false, active: true }
  attachment :image
end
