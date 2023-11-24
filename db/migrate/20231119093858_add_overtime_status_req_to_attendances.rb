class AddOvertimeStatusReqToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overtime_status_req, :string
  end
end
