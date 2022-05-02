# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    po { Faker::Movie.name }
    organization_id { Faker::Number.rand_in_range(1, 100) }
    customer_id { Faker::Number.rand_in_range(1, 100) }
    date { DateTime.now }
    deliver_date { Faker::Number.rand_in_range(1, 10).days.since }
    state { 'pending' }
  end
end
