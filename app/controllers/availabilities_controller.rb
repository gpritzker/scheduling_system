class AvailabilitiesController < ApplicationController
    # Endpoint to check a doctors availability
    #GET curl -X GET "http://localhost:3000/doctors/1/available_slots" is an Example to check a doctors availability
    def index
      doctor = Doctor.find(params[:id])
      #check the date requeste has available times or working hours
      general_availabilities = doctor.availabilities
      if general_availabilities.nil?
        render json: { message: "This doctor has no available times" }, status: :not_found
        return
      end
      # booked times for the doctor
      booked_slots_by_day = {}
      doctor.appointments.each do |appointment|
        weekday = appointment.date.strftime('%A').upcase
        booked_slots_by_day[weekday] ||= []
        booked_slots_by_day[weekday] << [appointment.start_time, appointment.end_time]
      end
      # calculate the free slots
      free_slots_by_day = {}
      general_availabilities.each do |availability|
        weekday = availability.weekday
        booked_for_day = booked_slots_by_day[weekday] || []
        free_slots = [[availability.start_time, availability.end_time]]
        free_slots.each do |slot_start, slot_end|
          booked_for_day.any? do |booked_start, booked_end|
            booked_start.to_time < slot_end.to_time && booked_end.to_time > slot_start.to_time
          end
        end

        free_slots_by_day[weekday] = free_slots unless free_slots.empty?
      end
      
    formatted_response = free_slots_by_day.map do |day, time_slots|
      {
        day: day,
        slots: time_slots.map do |time_slot|
          {
            start_time: time_slot[0].strftime("%H:%M"),
            end_time: time_slot[1].strftime("%H:%M")
          }
        end
      }
    end
      
      render json: formatted_response
    end
  end
  