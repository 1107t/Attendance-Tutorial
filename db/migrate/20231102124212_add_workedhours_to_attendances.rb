class AddWorkedhoursToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :workedhours, :datetime
  end
end
