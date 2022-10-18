class ChangeTourColumnNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tours, :title, false
    change_column_null :tours, :description, false
  end
end
