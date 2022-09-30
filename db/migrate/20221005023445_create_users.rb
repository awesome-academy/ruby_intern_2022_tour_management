class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.integer :role, default: 0
      t.string :phone_number
      t.text :info, null: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
