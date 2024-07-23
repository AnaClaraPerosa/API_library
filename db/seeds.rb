# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Loan.delete_all
Reservation.delete_all
Book.delete_all
Category.delete_all
Author.delete_all
User.delete_all

puts "Registering users..."

require_relative 'seeds/users'

####################################

puts "Registering authors..."

require_relative 'seeds/authors'

####################################

puts "Registering categories..."

require_relative 'seeds/categories'

####################################

puts "Registering books..."

require_relative 'seeds/books'

####################################

puts "Registering reservations..."

require_relative 'seeds/reservations'

####################################

puts "Registering loans..."

require_relative 'seeds/loans'

puts "Database seeded successfully!"
