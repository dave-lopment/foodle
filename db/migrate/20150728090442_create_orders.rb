class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.datetime :date_sent
      t.boolean :delivery_status, :default => false
      t.timestamps null: false
    end
  end
end
