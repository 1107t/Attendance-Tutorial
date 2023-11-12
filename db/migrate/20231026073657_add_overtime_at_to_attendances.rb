class AddOvertimeAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overtime_at, :datetime
  end
end
