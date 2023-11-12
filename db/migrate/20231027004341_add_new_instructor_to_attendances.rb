class AddNewInstructorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :new_instructor, :string
  end
end
