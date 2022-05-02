# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { Order.new }
  let(:invoice) { Invoice.new }

  it 'is valid with valid attributes' do
    order.assign_attributes(organization_id: 1, customer_id: 21, date: DateTime.now, deliver_date: 10.days.since)
    expect(order.valid?).to be_truthy
  end

  it 'is not valid without an email' do
    expect(order.valid?).to be_falsey
    expect(order.errors.full_messages).to include("Organization can't be blank")
    expect(order.errors.full_messages).to include("Customer can't be blank")
    expect(order.errors.full_messages).to include("Date can't be blank")
    expect(order.errors.full_messages).to include("Deliver date can't be blank")
  end

  it 'is not valid with a wrong deliver_date' do
    order.assign_attributes(organization_id: 1, customer_id: 21, date: DateTime.now, deliver_date: 10.days.ago)
    expect(order.valid?).to be_falsey
    expect(order.errors.full_messages.first).to include('Deliver date must be greater than')
  end

  context 'removing dependencies' do
    before do
      order.save
      invoice.save
    end

    it 'is remove dependent invoices' do
      order.delete
      expect(Invoice.all.count).to eq(0)
    end
  end
end
