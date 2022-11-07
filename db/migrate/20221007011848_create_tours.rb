class CreateTours < ActiveRecord::Migration[6.1]
  def change
    create_table :tours do |t|
      t.text :description
      t.text :title
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
