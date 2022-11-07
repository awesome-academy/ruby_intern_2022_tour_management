class AddTitleToTourSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_schedules, :title, :text
  end
end
