class AvailabilitiesController < ApplicationController
    # Endpoint to check a doctors availability
    #GET curl -X GET "http://localhost:3000/doctors/5/available_slots?date=2023-09-05" is an Example to check a doctors availability
    def index
      doctor = Doctor.find(params[:id])
    
      # date the doctor is requested
      date = Date.parse(params[:date])
      general_availabilities = doctor.availabilities.where(date: date)
    
      if general_availabilities.empty?
        render json: { message: "This doctor has no available dates." }, status: :not_found
        return
      end
    
      # booked times for the doctor
      booked_times = doctor.appointments.where(date: params[:date]).pluck(:start_time, :end_time).flatten
    
      # calculate the free slots
      free_slots = general_availabilities.reject do |slot|
        booked_times.any? do |start_time, end_time|
          # check if the start_time and end_time are between the slot start_time and end_time
          start_time < slot.end_time && end_time > slot.start_time
        end
      end
    
      # format the response
      formatted_slots = free_slots.map do |slot|
        {
          date: slot.date.strftime("%Y-%m-%d"),
          start_time: slot.start_time.strftime("%H:%M"),
          end_time: slot.end_time.strftime("%H:%M")
        }
      end
    
      render json: formatted_slots
    end
  end
  