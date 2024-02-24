class AddAfterWorkTimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :after_work_time, :datetime
  end
end
