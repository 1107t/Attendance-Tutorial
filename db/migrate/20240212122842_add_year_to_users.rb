class AddYearToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :year, :string
  end
end
