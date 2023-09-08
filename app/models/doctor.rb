class Doctor < ApplicationRecord
    has_many :availabilities, dependent: :destroy
    has_many :appointments, dependent: :destroy
    validates :name, presence: true

    def available_at?(doctor_id, date, start_time, end_time)
        appointments = Appointment.where(doctor_id: doctor_id)
        #convert start_time and end_time to Time objects
        # requested_start_time = Time.parse(start_time)
        # requested_end_time = Time.parse(end_time)
        requested_start_time = start_time
        requested_end_time = end_time
        # Verificar que el end_time sea posterior al start_time
        return false if requested_start_time >= requested_end_time

        # Search if the doctor already has an appointment in the requested time range
        overlapping_appointments = appointments.where(date: date).where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?)", requested_start_time, requested_start_time, requested_end_time, requested_end_time, requested_start_time, requested_end_time)
        #if overlapping appoitmens the doctor is not available
        overlapping_appointments.empty?
    end
      
end
