class AvailabilitiesController < ApplicationController
    # Endpoint to check a doctors availability
    #GET curl -X GET "http://localhost:3000/doctors/1/available_slots" is an Example to check a doctors availability
    def index
      doctor = Doctor.find(params[:id])
    
      # Check the doctor's general availabilities
      general_availabilities = doctor.availabilities
      if general_availabilities.empty?
        render json: { message: "This doctor has no available times" }, status: :not_found
        return
      end
    
      # Group booked times by day for the doctor
      booked_slots_by_day = {}
      doctor.appointments.each do |appointment|
        weekday = appointment.date.strftime('%A').upcase
        booked_slots_by_day[weekday] ||= []
        booked_slots_by_day[weekday] << [appointment.start_time, appointment.end_time]
      end
    
      # Calculate the free slots
      free_slots_by_day = {}
      general_availabilities.each do |availability|
        weekday = availability.weekday
        booked_for_day = booked_slots_by_day[weekday] || []
    
        free_slots = [[availability.start_time, availability.end_time]]
        booked_for_day.each do |booked_start, booked_end|
          free_slots = free_slots.flat_map do |slot_start, slot_end|
            if booked_start.to_time < slot_end.to_time && booked_end.to_time > slot_start.to_time
              [
                [slot_start, booked_start],
                [booked_end, slot_end]
              ]
            else
              [[slot_start, slot_end]]
            end
          end.select { |slot_start, slot_end| slot_start < slot_end } 
        end
    
        free_slots_by_day[weekday] = free_slots unless free_slots.empty?
      end
    
      # Format the response
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
  