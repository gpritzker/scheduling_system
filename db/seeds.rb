# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create doc
dr_john = Doctor.create!(name: "Dr. John Doe", specialty: "Cardiologist")
dr_jane = Doctor.create!(name: "Dr. Jane Doe", specialty: "Dentist")

# Availability for Dr. John
["WEDNESDAY", "FRIDAY", "MONDAY"].each do |day|
    Availability.create!(doctor: dr_john, weekday: day, start_time: "09:00", end_time: "17:00")
  end
["MONDAY", "TUESDAY"].each do |day|
    Availability.create!(doctor: dr_jane, weekday: day, start_time: "10:00", end_time: "18:00")
  end