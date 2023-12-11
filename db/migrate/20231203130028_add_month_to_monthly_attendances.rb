class AddMonthToMonthlyAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :monthly_attendances, :month, :string
  end
end
