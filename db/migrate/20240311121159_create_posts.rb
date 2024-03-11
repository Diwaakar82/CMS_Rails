class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :likes

      t.timestamps
    end

    change_column_default :posts, :likes, 0
  end
end
