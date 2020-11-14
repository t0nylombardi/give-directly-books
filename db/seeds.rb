require 'faker'

NUM_OF_SEEDS = 100

NUM_OF_SEEDS.times do |i|
  Book.create(
    available: true,
    title: Faker::Books::CultureSeries.book
  )
  puts "Inserted # #{i} seed into the database"
end