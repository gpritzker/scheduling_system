FactoryBot.define do
    factory :availability do
      association :doctor
      off_day { "Sunday" }
      weekday { "MONDAY" }
      start_time { "09:00" }
      end_time { "17:00" }
    end
  end