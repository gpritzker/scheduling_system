class Appointment < ApplicationRecord
  belongs_to :doctor
  validates :date, presence: true
  validates :start_time, presence: true, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "must be a valid time format (HH:MM)" }
  validates :end_time, presence: true, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "must be a valid time format (HH:MM)" }
end
