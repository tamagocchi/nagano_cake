class ChangeIsDeletedDefaultOnCustomer < ActiveRecord::Migration[5.2]
  def up
    change_column :customers, :is_deleted, :boolean, default: false, null: false
  end
end
