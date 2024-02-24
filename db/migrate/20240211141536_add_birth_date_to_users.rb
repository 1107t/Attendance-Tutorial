class AddBirthDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birth_date, :datetime
  end
end
