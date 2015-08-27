class AddUserIDtoOrders < ActiveRecord::Migration
  def up
    add_column :orders, :user_id, :integer, :default => -1
  end

  def down
    remove_column :orders, :user_id, :integer
  end
end
