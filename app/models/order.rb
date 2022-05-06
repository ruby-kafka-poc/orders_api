# frozen_string_literal: true

require 'kafka_rails_integration'

class Order < ApplicationRecord
  include KafkaRailsIntegration::Concerns::Model::Eventeable
  include Itemable

  validates :organization_id, :customer_id, :date, :deliver_date, presence: true
  validates :deliver_date, comparison: { greater_than: :date }

  has_one :invoice, dependent: :destroy
end
