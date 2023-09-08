class Availability < ApplicationRecord
  belongs_to :doctor
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate  :start_time_before_end_time

  def start_time_before_end_time
    errors.add(:start_time, "must be before end time") unless
      start_time < end_time
  end

end
