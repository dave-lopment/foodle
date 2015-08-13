class AddImageNameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :img_name, :string
  end
end
