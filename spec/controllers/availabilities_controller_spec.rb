# spec/controllers/availabilities_controller_spec.rb
require 'rails_helper'

RSpec.describe AvailabilitiesController, type: :controller do
  describe 'GET #index' do
    let(:doctor) { create(:doctor) } 


    context 'when doctor has availabilities' do
      before do
        create(:availability, doctor: doctor, weekday: 'MONDAY', start_time: '09:00', end_time: '17:00')
      end

      it 'returns available slots' do
        get :index, params: { id: doctor.id, weekday: 'MONDAY' } # guest that 5 of september is a Tuesday

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).size).to be > 0
      end
    end
  end
end
