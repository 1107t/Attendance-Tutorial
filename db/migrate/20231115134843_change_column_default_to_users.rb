class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.1]
  def change
     change_column_default :users, :basic_work_time, from: nil, to: "2023-08-28 10:00:00" 
     change_column_default :users, :designated_work_start_time, from: nil, to: "2023-08-28 09:00"
     change_column_default :users, :designated_work_end_time, from: nil, to: "2023-08-28 19:00"
  end
end
