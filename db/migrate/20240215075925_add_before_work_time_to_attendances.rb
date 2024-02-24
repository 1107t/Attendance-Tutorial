class AddBeforeWorkTimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :before_work_time, :datetime
  end
end
