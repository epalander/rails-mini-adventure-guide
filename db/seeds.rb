# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative "even_longer_adventurereviews"

puts "Cleaning reviews, adventures, users, and my adventure lists"
Review.destroy_all
MyAdventure.destroy_all
Adventure.destroy_all
User.destroy_all


puts "Seeding users"
user1 = User.create!(email: "lalala@gmail.com", password: "hellocucumber", admin: true)
user2 = User.create!(email: "somebody@gmail.com", password: "password123", admin: false)
user3 = User.create!(email: "dallas@hotmail.com", password: "yeehaw2020", admin: false)

puts "Seeding original adventures"
Adventure.create!(user_id: user1.id, title:"Rigi Trail Hike", address:"Naseggstrasse 4-6, 6415 Arth", description: "beautiful views and easy hike", category:"hiking trail", distance: 2, avg_duration: 60, stroller_friendly: true, youngest_age: 3, difficulty: 2, parking: true, public_transport: true, directions: "straight ahead and to the right")
Adventure.create!(user_id: user2.id, title:"Interlaken Hike", address:"Kammistrasse 13, 3800 Interlaken", description: "perfect hike for a weekend with the kids", category:"hiking trail", distance: 3, avg_duration: 80, stroller_friendly: false, youngest_age: 4, difficulty: 3, parking: true, public_transport: true, directions: "straight ahead and to the left")
Adventure.create!(user_id: user3.id, title:"Geneva Bike Trail", address:"Quai Gustave-Ador, 1207 Genève", description: "peaceful biking trail by the lake", category:"bike path", distance: 5.5, avg_duration: 120, stroller_friendly: true, youngest_age: 2, difficulty: 1, parking: true, public_transport: true, directions: "straight ahead")

puts "Seeding other adventures from adventures seed"
ADVENTURES.each do |adventure_args|
  new_adv = Adventure.new(adventure_args)
  new_adv.user_id = User.all.sample.id
  new_adv.save!
end

puts "Seeding My Adventures"
myadv1 = MyAdventure.create!(user_id: User.first.id, adventure_id: Adventure.first.id, done: true)
myadv2 = MyAdventure.create!(user_id: (User.first.id + 1), adventure_id: (Adventure.first.id + 1), done: false)
myadv3 = MyAdventure.create!(user_id: (User.first.id + 1), adventure_id: Adventure.first.id, done: true)
myadv4 = MyAdventure.create!(user_id: User.first.id, adventure_id: (Adventure.first.id + 2), done: false)

good_adjective = %w{adventurous amazing awesome breath-taking excellent fabulous fantastic gorgeous incredible ineffable outstanding perfect remarkable spectaular splendid stellar stupendous unbelievable wonderous}
bad_adjective = %w{boring bad sad not\ great not\ good not\ expected hard terrible unfortunate depressing disappointing ugly}

puts "Seeding reviews for each adventure"

def gen_review_content(adj)
  noun = %w{activity adventure memory trip experience fun time}
  phrases = ["We saw a #{Faker::Creature::Animal.name}!!!", "It was a #{adj.sample} #{noun.sample}.", "#{Faker::Creature::Animal.name.capitalize}s were everywhere!", "The #{%w{kids adults dogs grandparents cousins}.sample} had a #{adj.sample} time.", "We had #{%w{lunch dinner breakfast a\ picnic a\ snack a\ bite}.sample}.", "#{%w{I We The\ kids The\ grandparents The\ dogs}.sample} felt #{adj.sample} afterwards.", "It was #{adj.sample} through and through."]
  ending_pre =[]
  3.times { ending_pre << Faker::TvShows::DrWho.quote }
  ending = ending_pre.join(' ')
  content = phrases.sample(3).join(' ') + " " + ending + " " + phrases.sample(3).join(' ')
end

adventures = Adventure.all

users = User.all

adventures.each do |adventure|
  rand(3..5).times do
    good_review_args = {
      rating:rand(3..5),
      tagline: ["#{good_adjective.sample.capitalize} #{adventure.category} #{%w{for with}.sample} #{%w{kids the\ family}.sample}", "Could not be more #{good_adjective.sample.upcase}!", "#{%w{Simply Just}.sample} #{good_adjective.sample}", "#{good_adjective.sample.capitalize}!"].sample,
      content: gen_review_content(good_adjective),
      user_id: users.sample.id,
      adventure_id: adventure.id,
      difficulty: rand(1..3),
      duration: [(adventure.avg_duration - rand(0..15)), (adventure.avg_duration + rand(0..20))].sample,
      youngest_age: adventure.youngest_age < 2 ? rand(0..2) : rand(3..5)
    }
    Review.create!(good_review_args)
  end
  rand(0..2).times do
    bad_review_args = {
      rating:rand(1..2),
      tagline:["#{%w{omg jeez ugh}.sample}...#{bad_adjective.sample} #{%w{activity adventure memories memory trip experience experiences times time}.sample}", "Don't go!", "Just don't.", "Everyone was crying.", "#{%w{omg jeez ugh fml}.sample.capitalize}!", bad_adjective.sample.upcase].sample,
      content: gen_review_content(bad_adjective),
      user_id: users.sample.id,
      adventure_id: adventure.id,
      difficulty: 3,
      duration: adventure.avg_duration + rand(20..60),
      youngest_age: [4, 5].sample,
    }
    Review.create!(bad_review_args)
  end
end

puts "Finished!"

### HOW TO SEED WITH CLOUDINARY...don't do this or find a better way.
# -1. cloudinaryresources = Cloudinary::Api.resources("max_results" = [number_images_we_have])
# 0. have to get cloudinary metadata for checksums of images (can only do by Tier 2 membership-fuck that)
#     OR you know all the checksums in advance in another file.
# 1. get an image by:
#     cloudinaryexample = cloundinaryresources["resources"][index]
# 1. Create Blobs using new_blob = ActiveStorage::Blob.new
# 2. need to assign:
#     new_blob.key = cloudinaryexample["public_id"]
#     new_blob.checksum = "checksum_string...good luck getting this from cloudinary"
#     new_blob.content_type = "image/jpeg"
#     new_blob.byte_size = cloudinaryexample["bytes"]
#     new_blob.filename = "somefilename.jpg"
# 3. then do new_blob.save
# 4. get a review by
#       examplereview = Review.find(:id)
# 5. create new photo by
#       addphoto = examplereview.photos.new
# 6. then add the required values
#       addphoto.blob_id = new_blob.id
# 7. now save by
#       addphoto.save
#   Voila! What a fucking mess...

