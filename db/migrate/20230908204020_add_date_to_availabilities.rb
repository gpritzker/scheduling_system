class AddDateToAvailabilities < ActiveRecord::Migration[7.0]
  def change
    add_column :availabilities, :date, :date
  end
end
