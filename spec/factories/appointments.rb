FactoryBot.define do
  factory :appointment do
    doctor
    date { "2024-01-01" }
    start_time { "09:00" }
    end_time { "10:00" }
  end
end
