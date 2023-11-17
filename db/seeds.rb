# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  employee_number = n
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               employee_number: employee_number)
               
 User.create(name: "上長A",
            email: "super-1@email.com",
            password: "password",
            password_confirmation: "password",
            superior: true) 
 User.create(name: "上長B",
            email: "super-2@email.com",
            password: "password",
            password_confirmation: "password",
            superior: true) 
 User.create(name: "桜木花道",
            email: "sakuragi@email.com",
            password: "password",
            password_confirmation: "password",
            superior: true)               
end