class RenameJoinTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :Categories_Posts, :categories_posts
  end
end
