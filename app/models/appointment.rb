class Appointment < ApplicationRecord
  belongs_to :doctor
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
