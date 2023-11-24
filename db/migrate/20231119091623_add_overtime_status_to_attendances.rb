class AddOvertimeStatusToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overtime_status, :datetime
  end
end
