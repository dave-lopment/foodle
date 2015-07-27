class ChangeNames < ActiveRecord::Migration
  def change
    rename_column :users, :email_adress, :email_address
  end
end
