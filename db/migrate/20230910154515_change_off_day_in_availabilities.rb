class ChangeOffDayInAvailabilities < ActiveRecord::Migration[6.0]
  def change
    # change_column off_day to string
    change_column :availabilities, :off_day, :string
    
    # remove date column
    remove_column :availabilities, :date
  end
end
