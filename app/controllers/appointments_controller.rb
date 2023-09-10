class AppointmentsController < ApplicationController
    #Endpoint to book a doctors open slot
    #POST http://localhost:3000/doctors/:id/appointments
    #Example:  curl -X POST \
    #  -H "Content-Type: application/json" \
    #  -d '{ "appointment": { "date": "2023-09-01", "start_time": "12:00", "end_time": "13:00" } }' \
    #  http://localhost:3000/doctors/2/appointments

    def create
      doctor = Doctor.find(params[:doctor_id])
       # Check if the doctor exists
      unless doctor
        render json: { error: 'Doctor not found.' }, status: :not_found
        return
      end
        if doctor.available_at?(params[:doctor_id], params[:appointment][:date], params[:appointment][:start_time], params[:appointment][:end_time])
            appointment = Appointment.new(appointment_params)
            appointment.doctor_id = params[:doctor_id]
            if appointment.save!
                render json: { message: 'Appointment booked.' }, status: :created
            else
                render json: appointment.errors, status: :unprocessable_entity
            end
        else
            # if the doctor is not available at the requested time
            render json: { error: 'Doctor is not available at the requested time.' }, status: :unprocessable_entity
        end
    end
  
    # Endpoint to update an appointment
    # curl -X PUT http://localhost:3000/doctors/:doctor_id/appointments/:id \
    #  -H "Content-Type: application/json" \
    #  -d '{"appointment": {"date": "2023-10-01", "start_time": "15:00", "end_time": "16:00"}}'
    # Example to update an appointment
    #  curl -X PUT http://localhost:3000/doctors/1/appointments/1 \  
    #  -H "Content-Type: application/json" \
    #  -d '{"appointment": {"date": "2023-10-01", "start_time": "15:00", "end_time": "16:00"}}'

    def update
      appointment = Appointment.where(id: params[:id]).first
      #validate if an appointment exists
        unless appointment
            render json: { error: 'Appointment not found.' }, status: :not_found
            return
        end
        #validate if the doctor is available at the requested time
        doctor = Doctor.find(params[:doctor_id])
        unless doctor.available_at?(params[:doctor_id], params[:appointment][:date], params[:appointment][:start_time], params[:appointment][:end_time])
            render json: { error: 'Doctor is not available at the requested time.' }, status: :unprocessable_entity
            return
        end
        #update the appointment
        if appointment.update(appointment_params)
            render json: { message: 'Appointment updated.' }
        else
            render json: appointment.errors, status: :unprocessable_entity
        end
    end
  
    # Endpoint to delete an appointment
    #curl -X DELETE http://localhost:3000/doctors/:doctor_id/appointments/:id
    #example curl -X DELETE http://localhost:3000/doctors/1/appointments/1

    def destroy
      appointment = Appointment.where(id: params[:id]).first
      doctor = Doctor.find(params[:doctor_id])
       #verify if the doctor exists
        unless doctor
            render json: { error: 'Doctor not found.' }, status: :not_found
            return
        end
       #verify if the appointment exists
        unless appointment
            render json: { error: 'Appointment not found.' }, status: :not_found
            return
        end
      appointment.destroy
      render json: { message: 'Appointment deleted.' }
    end
  
    private
  
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :date, :start_time, :end_time)
    end
  end
  