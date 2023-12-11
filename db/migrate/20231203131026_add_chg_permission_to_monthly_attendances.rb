class AddChgPermissionToMonthlyAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :monthly_attendances, :chg_permission, :boolean
  end
end
