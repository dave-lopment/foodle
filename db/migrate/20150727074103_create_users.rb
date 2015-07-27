class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :postal
      t.string :email_adress
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
