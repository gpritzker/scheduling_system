class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.references :doctor, null: false, foreign_key: true
      t.date :off_day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
