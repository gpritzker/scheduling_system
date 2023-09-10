# spec/controllers/appointments_controller_spec.rb

require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:doctor) { create(:doctor) }
  let(:appointment) { create(:appointment, doctor: doctor) } 
  let!(:availability) { create(:availability, doctor: doctor) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new appointment' do
        expect { post :create, params: { doctor_id: doctor.id, appointment: attributes_for(:appointment) }}.to change(Appointment, :count).by(1)
      end

      # validate when doctor is not available
        it 'returns an error when doctor is not available' do
            appointment = create(:appointment, doctor: doctor)
            post :create, params: { doctor_id: doctor.id, appointment: { date: "2024-01-01", start_time: "09:00", end_time: "10:00" } }
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end
  end
  
  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the appointment' do
        put :update, params: { doctor_id: doctor.id, id: appointment.id, appointment: { date: "2023-09-08", start_time: "16:00", end_time: "17:00" } }
        appointment.reload
        expect(appointment.date.strftime('%Y-%m-%d')).to eq("2023-09-08")
      end

    end
  end
  
  describe 'DELETE #destroy' do
    it 'deletes the appointment' do
      delete :destroy, params: { doctor_id: doctor.id, id: appointment.id }
      expect(Appointment.count).to eq(0)
    end
  end
end
