class AddAttendanceChgStatusToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :attendance_chg_status, :string
  end
end
