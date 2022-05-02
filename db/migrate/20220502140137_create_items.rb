# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :itemable, polymorphic: true, null: false
      t.integer :quantity, null: false
      t.string :description, null: false
      t.string :code, null: false
      t.decimal :amount, null: false, precision: 11, scale: 2

      t.timestamps
    end
  end
end
