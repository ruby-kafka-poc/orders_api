# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    quantity { rand(10) }
    description { Faker::Lorem.sentence }
    code { Faker::Lorem.word }
    amount { rand(1..1000) / 100 }
  end
end
