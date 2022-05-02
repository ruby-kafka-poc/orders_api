# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :itemable, polymorphic: true

  validates :quantity, :description, :code, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  # alias_method :order, :itemable
  # alias_method :invoice, :itemable
end
