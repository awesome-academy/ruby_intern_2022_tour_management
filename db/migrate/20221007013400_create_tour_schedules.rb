class CreateTourSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_schedules do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
