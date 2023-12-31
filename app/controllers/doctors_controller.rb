class DoctorsController < ApplicationController
    # Endpoint to show a doctors information
    #GET http://localhost:3000/doctors/:id
    def index
        @doctors = Doctor.all
        render json: @doctors
    end

    def show
      doctor = Doctor.find(params[:id])
      render json: doctor
    end
    
    # Endpoint to show a doctors working_hours and day off information
    #GET http://localhost:3000/doctors/:doctor_id/working_hours
    #EXAMPLE GET http://localhost:3000/doctors/1/working_hours
    def working_hours
        doctor = Doctor.find(params[:id])
        days_off = doctor.availabilities.pluck(:off_day).compact.uniq

            # Mapea las disponibilidades para obtener solo los horarios
        working_hours = doctor.availabilities.map do |availability|
            {
                day: availability.weekday,
                start_time: format_time_only(availability.start_time), 
                end_time: format_time_only(availability.end_time)
            }
        end

        # JSON
        render json: {working_hours: working_hours }

    end

    private
    def format_time_only(datetime)
        datetime.strftime("%H:%M")
    end
  end