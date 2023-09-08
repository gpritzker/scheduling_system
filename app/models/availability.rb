class Availability < ApplicationRecord
  belongs_to :doctor
  validates :start_time, presence: true, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "should be a valid time format (HH:MM)" }
  validates :end_time, presence: true, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "should be a valid time format (HH:MM)" }
  validates :date, presence: true

  validate  :start_time_before_end_time

  def start_time_before_end_time
    errors.add(:start_time, "must be before end time") unless
      start_time < end_time
  end

end
