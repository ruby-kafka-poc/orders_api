# frozen_string_literal: true

class Order < ApplicationRecord
  include Itemable

  validates :organization_id, :customer_id, :date, :deliver_date, presence: true
  validates :deliver_date, comparison: { greater_than: :date }

  has_one :invoice, dependent: :destroy
end
