class AddApplicantsToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :applicants, :string
  end
end
