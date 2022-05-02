# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :po
      t.integer :organization_id, null: false
      t.integer :customer_id, null: false
      t.datetime :date, null: false
      t.datetime :deliver_date, null: false
      t.string :state
      t.belongs_to :order, foreign_key: true

      t.timestamps
    end
  end
end
