class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :postal, :integer 
  end
end
