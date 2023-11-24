class RemoveOvertimeStatusfromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :overtime_status, :datetime
  end
end
