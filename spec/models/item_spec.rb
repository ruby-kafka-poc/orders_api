# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.new }

  it 'is valid with valid attributes' do
    item.assign_attributes(
      itemable: Order.new,
      quantity: 3,
      description: Faker::Lorem.sentence,
      code: Faker::Lorem.word,
      amount: rand(1..1000) / 100
    )
    expect(item.valid?).to be_truthy
  end

  it 'is not valid without an order' do
    expect(item.valid?).to be_falsey
    expect(item.errors.full_messages).to include('Itemable must exist')
    expect(item.errors.full_messages).to include("Quantity can't be blank")
    expect(item.errors.full_messages).to include("Description can't be blank")
    expect(item.errors.full_messages).to include("Code can't be blank")
    expect(item.errors.full_messages).to include("Amount can't be blank")
    expect(item.errors.full_messages).to include('Amount is not a number')
  end

  it 'is not valid with a wrong amount' do
    item.assign_attributes(amount: -12.34)
    expect(item.valid?).to be_falsey
    expect(item.errors.full_messages).to include('Amount must be greater than or equal to 0')
  end
end
