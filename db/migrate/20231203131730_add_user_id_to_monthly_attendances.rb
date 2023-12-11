class AddUserIdToMonthlyAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :monthly_attendances, :user_id, :integer
  end
end
