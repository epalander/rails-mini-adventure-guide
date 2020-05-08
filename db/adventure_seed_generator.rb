#### INSTRUCTIONS:
#### Be sure to remember to
#### 1) write 'ADVENTURES =' in the new seed file and
#### 2) to change require_relative in the seeds.rb file to new seed file name
#### 3) delete the old seed file or put it into a seed_archive folder

require 'geocoder'
require 'faker'

# ##### Zurich
# ## Top Left: 47.470644, 8.408002
# ## Bottom Right: 47.309827, 8.637376
puts "Generating random locations in Zurich"
zurich = []
30.times do
  zurich << Geocoder.search([rand(47.309827..47.470644).round(6), rand(8.408002..8.637376).round(6)])
end
puts "Finished generating random locations in Zurich"

# # # #### Lausanne
# # # ## Top Left: 46.625335, 6.570462
# # # ## Bottom Right: 46.512499, 6.760876
puts "Generating random locations in Lausanne"
lausanne = []
30.times do
  lausanne << Geocoder.search([rand(46.512499..46.625335).round(6), rand(6.570462..6.760876).round(6)])
end
puts "Finished generating random locations in Lausanne"

# # #### Switzerland
# # ## 47.691867, 5.901837
# # ## 46.3328867,10.4005823
puts "Generating random locations in Switzerland"
switzerland = []
40.times do
  switzerland << Geocoder.search([rand(46.3328867..47.691867).round(6), rand(5.901837..10.4005823).round(6)])
end
puts "Finished generating random locations in Switzerland"

good_adjective = %w{adventurous amazing awesome breath-taking excellent fabulous fantastic gorgeous incredible ineffable outstanding perfect remarkable spectaular splendid stellar stupendous unbelievable wonderous}
bad_adjective = %w{boring bad sad not\ great not\ good not\ expected hard terrible unfortunate depressing disappointing ugly}

def seed_adventures(local, good)
  adventures = []
  got_quotes = []
  rand(8..10).times { got_quotes << Faker::TvShows::GameOfThrones.quote }
  got_joined = got_quotes.join(' ')
  pb_quotes = []
  rand(2..4).times { pb_quotes << Faker::Movies::PrincessBride.quote }
  pb_joined = pb_quotes.join(' ')
  local.each do |place|
    adventure_args = {
    title: "#{good.sample.capitalize} #{%w{activity adventure memories memory trip experience experiences fun times time}.sample} #{%w{near close\ to in around by}.sample} #{place.first.city}",
    address: place.first.address,
    description: "#{["This will be a #{good.sample} time with your mini and you will see #{good.sample} things. Don't feed the #{%w{bears sheep cows gremlins\ after\ midnight}.sample}...", "Your #{good.sample} kids can run around free with not a care in the world. Check out the #{%w{trees local\ jams cheese cows chocolate watches bears fish leprechauns}.sample}!", "Enjoy this #{good.sample} #{%w{activity adventure memory trip experience fun time}.sample} with your family. Watch out for wildlife!"].sample} #{got_joined}",
    category: ["hiking trail", "bike path"].sample,
    distance: rand(0.1..15.0).round(1),
    avg_duration: [15, 30, 45, 60, 90, 120, 150, 180, 210, 240, 270, 300].sample,
    stroller_friendly: [true, false].sample,
    youngest_age: (0..5).to_a.sample,
    difficulty: [1, 2, 3].sample,
    parking: [true, false].sample,
    public_transport: [true, false].sample,
    directions: "#{%w{Go Look Walk Twenty\ steps}.sample} #{%w{straight left right straight straight\ ahead east west north south}.sample}. #{pb_joined} #{["Don't get lost!", "You can't miss it!"].sample}",
    latitude: place.first.latitude,
    longitude: place.first.longitude
    }
    # Adventure.create!(adventure_args)
    adventure_args[:description] = adventure_args[:description][0..999]
    adventure_args[:directions] = adventure_args[:directions][0..599]
    adventures << adventure_args
  end
  return adventures
end
# puts "Seeding random Adventures"
swiss_adv = seed_adventures(switzerland, good_adjective)
zurich_adv = seed_adventures(zurich, good_adjective)
lausanne_adv = seed_adventures(lausanne, good_adjective)
all_adv = swiss_adv + zurich_adv + lausanne_adv

filename = "#{Time.now.to_i.to_s}_adventureseed.rb"
File.write(filename, all_adv)
