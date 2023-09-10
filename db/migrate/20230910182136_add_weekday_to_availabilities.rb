class AddWeekdayToAvailabilities < ActiveRecord::Migration[7.0]
  def change
    add_column :availabilities, :weekday, :string
  end
end
