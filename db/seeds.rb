# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
User.create!(email: 'admin@test.com',    password: 'password', role: :admin,   display_name: 'Admin')
User.create!(email: 'support@test.com',  password: 'password', role: :support, display_name: 'Support Agent')
User.create!(email: 'sales@test.com',    password: 'password', role: :sales,   display_name: 'Sales Rep')
User.create!(email: 'user@test.com',     password: 'password', role: :user,    display_name: 'John Doe')
User.create!(email: 'user@test.com',     password: 'password', role: :user,    display_name: 'John Doe')
User.create!(email: 'user2@test.com', password: 'password', role: :user,    display_name: 'Johana Doe')
