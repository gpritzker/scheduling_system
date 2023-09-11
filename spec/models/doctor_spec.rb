# spec/models/doctor_spec.rb

require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'validations' do
    it 'requires a name' do
      doctor_without_name = Doctor.new(name: nil)
      expect(doctor_without_name.valid?).to be_falsey
      expect(doctor_without_name.errors[:name]).to include("can't be blank")
    end
  end

  describe '#available_at?' do
    let(:doctor) { create(:doctor) }

    context 'when there are no overlapping appointments' do
      before do
        # Create a non-overlapping appointment for the doctor
        create(:appointment, doctor: doctor, date:  "2023-09-6", start_time: "10:00", end_time: "11:00")
      end

      it 'returns false for non-overlapping times' do
        expect(doctor.available_at?(doctor.id, "2023-09-8", "11:00", "12:00")).to be_falsey
      end

      it 'returns false for overlapping times' do
        expect(doctor.available_at?(doctor.id, "2023-09-6", "10:30", "11:30")).to be_falsey
      end
    end

    context 'when there is an overlapping appointment' do
      before do
        # Create an overlapping appointment for the doctor
        create(:appointment, doctor: doctor, date:  "2023-09-8", start_time: "10:00", end_time: "12:00")
      end

      it 'returns false for overlapping times' do
        expect(doctor.available_at?(doctor.id, "2023-09-8", "09:00", "10:00")).to be_falsey
      end
    end
  end
end
