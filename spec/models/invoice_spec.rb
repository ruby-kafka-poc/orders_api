# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:order) { Order.new }
  let(:invoice) { Invoice.new }

  it 'is valid with valid attributes' do
    invoice.assign_attributes(
      organization_id: 1, customer_id: 21, date: DateTime.now, deliver_date: 10.days.since, order:
    )
    expect(invoice.valid?).to be_truthy
  end

  it 'is not valid without an order' do
    expect(invoice.valid?).to be_falsey
    expect(invoice.errors.full_messages).to include("Organization can't be blank")
    expect(invoice.errors.full_messages).to include("Customer can't be blank")
    expect(invoice.errors.full_messages).to include("Date can't be blank")
    expect(invoice.errors.full_messages).to include("Deliver date can't be blank")
    expect(invoice.errors.full_messages).to include('Order must exist')
  end

  it 'is not valid with a wrong deliver_date' do
    invoice.assign_attributes(organization_id: 1, customer_id: 21, date: DateTime.now, deliver_date: 10.days.ago)
    expect(invoice.valid?).to be_falsey
    expect(invoice.errors.full_messages.first).to include('Deliver date must be greater than')
  end
end
