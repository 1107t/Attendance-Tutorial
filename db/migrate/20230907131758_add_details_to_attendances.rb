class AddDetailsToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :attendance_nextday, :integer
    add_column :attendances, :instructor, :string
  end
end
