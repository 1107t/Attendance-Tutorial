class AddChgatToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :chg_started_at, :datetime
    add_column :attendances, :chg_finished_at, :datetime
  end
end
