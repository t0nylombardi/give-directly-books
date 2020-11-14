require 'faker'

FactoryBot.define do
  factory :book do
    available { true }
    title { Faker::Books::CultureSeries.book }
    timestamp { "" }
  end
end
