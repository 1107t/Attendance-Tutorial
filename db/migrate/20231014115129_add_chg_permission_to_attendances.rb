class AddChgPermissionToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :chg_permission, :boolean
  end
end
