# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create doc
dr_john = Doctor.create(name: "Dr. John Doe")
dr_jane = Doctor.create(name: "Dr. Jane Doe")

# Availability for Dr. John
Availability.create(doctor: dr_john,  date: "2023-09-19", off_day: "Sunday", start_time: "09:00", end_time: "17:00")
Availability.create(doctor: dr_john,  date: "2023-09-18", off_day: "Sunday", start_time: "09:00", end_time: "15:00")

# Availability for Dr. Jane
Availability.create(doctor: dr_jane,  date: "2023-09-15", off_day: "Sunday", start_time: "10:00", end_time: "18:00")
