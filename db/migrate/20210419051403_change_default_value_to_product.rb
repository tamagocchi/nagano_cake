class ChangeDefaultValueToProduct < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :is_active,:boolean, default: true
  end
end
