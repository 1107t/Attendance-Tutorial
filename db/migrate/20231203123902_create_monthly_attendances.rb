class CreateMonthlyAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :monthly_attendances do |t|
      t.string :master
      t.string :instructor
      t.string :master_status

      t.timestamps
    end
  end
end
