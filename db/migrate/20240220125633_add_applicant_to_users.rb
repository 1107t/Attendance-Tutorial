class AddApplicantToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :applicant, :string
  end
end
