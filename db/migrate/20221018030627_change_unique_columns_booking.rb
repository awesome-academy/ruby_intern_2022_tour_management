class ChangeUniqueColumnsBooking < ActiveRecord::Migration[6.1]
  def change
    add_index :bookings, [:user_id, :tour_schedule_id], unique: true
  end
end
