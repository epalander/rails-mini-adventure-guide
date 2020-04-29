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

puts "Seeding original adventures"
Adventure.create!(title:"Rigi Trail Hike", address:"Naseggstrasse 4-6, 6415 Arth", description: "beautiful views and easy hike", category:"hiking trail", distance: 2, avg_duration: 60, stroller_friendly: true, youngest_age: 3, difficulty: 2, parking: true, public_transport: true, directions: "straight ahead and to the right")
Adventure.create!(title:"Interlaken Hike", address:"Kammistrasse 13, 3800 Interlaken", description: "perfect hike for a weekend with the kids", category:"hiking trail", distance: 3, avg_duration: 80, stroller_friendly: false, youngest_age: 4, difficulty: 3, parking: true, public_transport: true, directions: "straight ahead and to the left")
Adventure.create!(title:"Geneva Bike Trail", address:"Quai Gustave-Ador, 1207 Genève", description: "peaceful biking trail by the lake", category:"bike path", distance: 5.5, avg_duration: 120, stroller_friendly: true, youngest_age: 2, difficulty: 1, parking: true, public_transport: true, directions: "straight ahead")

good_adjective = %w{adventurous amazing awesome breath-taking excellent fabulous fantastic gorgeous incredible ineffable outstanding perfect remarkable spectaular splendid stellar stupendous unbelievable wonderous}
bad_adjective = %w{boring bad sad not\ great not\ good not\ expected hard terrible unfortunate depressing disappointing ugly}

##### Zurich
## Top Left: 47.470644, 8.408002
## Bottom Right: 47.309827, 8.637376
puts "Generating random locations in Lausanne"
zurich = []
10.times do
  zurich << Geocoder.search([rand(47.309827..47.470644).round(6), rand(8.408002..8.637376).round(6)])
end
puts "Finished generating random locations in Zurich"

# #### Lausanne
# ## Top Left: 46.625335, 6.570462
# ## Bottom Right: 46.512499, 6.760876
puts "Generating random locations in Lausanne"
lausanne = []
10.times do
  lausanne << Geocoder.search([rand(46.512499..46.625335).round(6), rand(6.570462..6.760876).round(6)])
end
puts "Finished generating random locations in Lausanne"

#### Switzerland
## 47.691867, 5.901837
## 46.3328867,10.4005823
puts "Generating random locations in Switzerland"
switzerland = []
10.times do
  switzerland << Geocoder.search([rand(46.3328867..47.691867).round(6), rand(5.901837..10.4005823).round(6)])
end
puts "Finished generating random locations in Switzerland"

def seed_adventures(local, good)
  local.each do |place|
    adventure_args = {
    title: "#{good.sample.capitalize} #{%w{activity adventure memories memory trip experience experiences fun times time}.sample} #{%w{near close\ to in around by}.sample} #{place.first.city}",
    address: place.first.address,
    description: ["This will be a #{good.sample} time with your mini and you will see #{good.sample} things. Don't feed the #{%w{bears sheep cows gremlins\ after \midnight}.sample}...", "Your #{good.sample} kids can run around free with not a care in the world. Check out the #{%w{trees local\ jams cheese cows chocolate watches bears fish leprechauns}.sample}!", "Enjoy this #{good.sample} #{%w{activity adventure memory trip experience fun time}.sample} with your family. Watch out for wildlife!"].sample,
    category: ["hiking trail", "bike path"].sample,
    distance: rand(0.1..15.0).round(1),
    avg_duration: (20..240).to_a.sample,
    stroller_friendly: [true, false].sample,
    youngest_age: (0..5).to_a.sample,
    difficulty: [1, 2, 3].sample,
    parking: [true, false].sample,
    public_transport: [true, false].sample,
    directions: "#{%w{Go Look Walk Twenty\ steps}.sample} #{%w{straight left right straight straight\ ahead east west north south}.sample}. #{["Don't get lost!", "You can't miss it!"].sample}",
    latitude: place.first.latitude,
    longitude: place.first.longitude
    }
    Adventure.create!(adventure_args)
  end
end
puts "Seeding random Adventures"
seed_adventures(switzerland, good_adjective)
seed_adventures(zurich, good_adjective)
seed_adventures(lausanne, good_adjective)

def seed_reviews
end

# puts "Seeding reviews"
# Review.create!(rating: 4.5, content: "The kids loved it and it had wonderful views!", tagline: "Wonderful views!", user: user1, adventure: Adventure.last)
# Review.create!(rating: 3.2, content: "It was the perfect hike for the weekend!", tagline: "Perfect Hike!", user: user2, adventure: Adventure.first)
# Review.create!(rating: 5.0, content: "Bike ride by the lake was so peaceful!", tagline: "Peaceful Bike Ride!", user: user3, adventure: Adventure[1])


puts "Finished!"
