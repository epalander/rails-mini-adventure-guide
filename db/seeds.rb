# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning reviews, adventures, users"
Review.destroy_all
Adventure.destroy_all
User.destroy_all


puts "Seeding users"
user1 = User.create!(email: "lalala@gmail.com", password: "hellocucumber")
user2 = User.create!(email: "somebody@gmail.com", password: "password123")
user3 = User.create!(email: "dallas@hotmail.com", password: "yeehaw2020")

puts "Seeding adventures"
Adventure.create!(title:"Rigi Trail Hike", description: "beautiful views and easy hike", category:"hiking trail", distance: 2, avg_duration: 60, stroller_friendly: true, avg_rating: 4, youngest_age: 6, difficulty: 3, parking: true, public_transport: true, directions: "straight ahead and to the right")
Adventure.create!(title:"Interlaken Hike", description: "perfect hike for a weekend with the kids", category:"hiking trail", distance: 3, avg_duration: 80, stroller_friendly: false, avg_rating: 5, youngest_age: 10, difficulty: 5, parking: true, public_transport: true, directions: "straight ahead and to the left")
Adventure.create!(title:"Geneva Bike Trail", description: "peaceful biking trail by the lake", category:"bike path", distance: 5, avg_duration: 120, stroller_friendly: true, avg_rating: 3, youngest_age: 4, difficulty: 2, parking: true, public_transport: true, directions: "straight ahead")

# puts "Seeding reviews"
# Review.create!(rating: 4.5, content: "The kids loved it and it had wonderful views!", tagline: "Wonderful views!", user: user1, adventure: Adventure.last)
# Review.create!(rating: 3.2, content: "It was the perfect hike for the weekend!", tagline: "Perfect Hike!", user: user2, adventure: Adventure.first)
# Review.create!(rating: 5.0, content: "Bike ride by the lake was so peaceful!", tagline: "Peaceful Bike Ride!", user: user3, adventure: Adventure[1])

puts "Finished!"
