# README
# Scheduling System
* The Scheduling System allows for the management of appointments between patients and doctors. This system supports operations like creating, updating, and checking the availability of doctors for appointments.

# Scheduling System - Design and Data Models Overview
# Thought Process
## Problem Definition:

Recognized the need for a system where patients can schedule appointments with doctors based on the doctors' availabilities.
User Experience:

Wanted to create an intuitive interface where the availability of a doctor can be checked in real-time to prevent scheduling conflicts.
Scalability and Flexibility:

Ensured the system can accommodate a growing number of doctors and patients without sacrificing performance.
Designed the system in a way that new features or changes to the scheduling logic can be added with minimal disruption.
Data Integrity:

Introduced validations and checks to ensure appointment overlaps don't happen and data integrity is maintained.
# Data Models
## Doctor:

Attributes: name
Associations:
Has many availabilities
Has many appointments
Validations: Name presence

## Availability:

Attributes: start_time, end_time, off_day
Associations:
Belongs to doctor
Purpose: To indicate the timeframes during which a doctor is available for appointments. The off_day denotes days when the doctor isn't working.

## Appointment:

Attributes: date, start_time, end_time
Associations:
Belongs to doctor
Purpose: Represents a scheduled appointment for a doctor.

# Table of Contents
* Prerequisites
* Setup
* Usage
* Running Tests
* Endpoints

## Prerequisites
- Ruby 2.7.2
- Rails 6.x
- PostgreSQL
Setup
## Clone the repository:
1. git clone https://github.com/yourusername/scheduling_system.git
2. cd scheduling_system
* Install required gems:
3. bundle install
## Setup the database:
4. rails db:create db:create
5. rails db:create db:migrate
6. rails db:create db:seed
* for DB use postgresql and file .env to make 
  ## - CLINIC_APP_DATABASE_PASSWORD='your_db_password'
## Start the Rails server:
7. rails server
* By default, the server will run on http://localhost:3000.

# Usage
Once the server is up and running, you can navigate to it in your browser or use tools like curl or Postman to interact with the API.

# Running Tests
We use RSpec for testing. To run tests:
- rspec

# Endpoints
# Doctors
## Endpoint to show all doctors
    #GET http://localhost:3000/doctors
## Endpoint to show a doctors information
    #GET http://localhost:3000/doctors/:id
    #EXAMPLE GET http://localhost:3000/doctors/1
## Endpoint to show a doctors working_hours and day off information
    #GET http://localhost:3000/doctors/:doctor_id/working_hours
    #EXAMPLE GET http://localhost:3000/doctors/1/working_hours

# Availability
## Endpoint to check a doctors availability
    #GET GET curl -X GET "http://localhost:3000/doctors/1/available_slots? is an Example to check a doctors availability

# Appointments
## Endpoint to show all appointment for a doctor
    #GET http://localhost:3000/doctors/:id/appointments
    example http://localhost:3000/doctors/1/appointments

## Endpoint to book an appointment for a doctor's available slot.
 Method: POST
 URL: http://localhost:3000/doctors/:id/appointments

## Parameters:
 - date: The date of the appointment (format: "YYYY-MM-DD").
 - start_time: The starting time of the appointment (format: "HH:MM").
 - end_time: The ending time of the appointment (format: "HH:MM").

## Example using curl:
 #curl --location 'http://localhost:3000/doctors/1/appointments' \
 #--header 'Content-Type: application/json' \
 #--data '{ "appointment": 
     #{ "date": "2023-09-08", 
      #"start_time": "12:00", 
      #"end_time": "13:00" } }'

## Endpoint to update an existing appointment for a doctor.
Method: PUT
  URL: http://localhost:3000/doctors/:doctor_id/appointments/:id
Parameters:
- date: The updated date for the appointment (format: "YYYY-MM-DD").
- start_time: The updated starting time of the appointment (format: "HH:MM").
- end_time: The updated ending time of the appointment (format: "HH:MM").
## Usage using curl:
   #curl -X PUT http://localhost:3000/doctors/:doctor_id/appointments/:id \
     #H "Content-Type: application/json" \
     #d '{"appointment": {"date": "2023-10-01", "start_time": "15:00", "end_time": "16:00"}}'
  
## Example to update an appointment with specific IDs:
  #curl -X PUT http://localhost:3000/doctors/1/appointments/1 \
    #-H "Content-Type: application/json" \
    #-d '{"appointment": {"date": "2023-10-01", "start_time": "15:00", "end_time": "16:00"}}'

## Endpoint to delete an appointment
    #curl -X DELETE http://localhost:3000/doctors/:doctor_id/appointments/:id
    #example curl -X DELETE http://localhost:3000/doctors/1/appointments/1

