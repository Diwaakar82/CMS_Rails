class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories_posts, :Category_id, :category_id
    rename_column :categories_posts, :Post_id, :post_id
  end
end
