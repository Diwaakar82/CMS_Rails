class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_column :users, :confirmed_at, :datetime
    add_column :users, :password_digest, :string, null: false
  end
end
