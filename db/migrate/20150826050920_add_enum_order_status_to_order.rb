class AddEnumOrderStatusToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :order_status, :integer, :default => 0
  end

  def down
    remove_column :orders, :order_status, :integer
  end
end
