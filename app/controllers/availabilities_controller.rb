class AvailabilitiesController < ApplicationController
    # Endpoint to check a doctors availability
    #GET http://localhost:3000/doctors/:id/availabilities
    #GET http://localhost:3000/doctors/1/availabilities  is an Example to check a doctors availability
    def index
      doctor = Doctor.find(params[:doctor_id])

      general_hours = doctor.availabilities
      booked_times = doctor.appointments.pluck(:start_time, :end_time).flatten
  
      free_slots = general_hours.reject do |slot|
        booked_times.any? { |time| time >= slot.start_time && time <= slot.end_time }
      end
  
      # format the response
      formatted_slots = free_slots.map do |slot|
        {
          start_time: format_datetime(slot.start_time),
          end_time: format_datetime(slot.end_time)
        }
      end
  
      render json: formatted_slots
    end
  
    private
    def format_datetime(datetime)
      datetime.strftime("%Y-%m-%d %H:%M")
    end
  end
  