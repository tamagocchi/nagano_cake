class AddDefaultNullFalseToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    change_column :order_details, :making_status, :integer, null: false, default: 0
  end
end
