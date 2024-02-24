class AddMonthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :month, :string
  end
end
