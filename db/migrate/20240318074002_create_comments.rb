class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :text

      t.timestamps
    end

    add_reference :comments, :post, foreign_key: true
  end
end