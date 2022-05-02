# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :organization_id, :customer_id, :date, :deliver_date, presence: true
  validates :deliver_date, comparison: { greater_than: :date }

  belongs_to :order
end
