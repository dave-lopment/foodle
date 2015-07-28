class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :description
      t.boolean :isVegetarian

      t.timestamps null: false
    end
  end
end
