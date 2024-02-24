class AddSaveDayToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :save_day, :datetime
  end
end
