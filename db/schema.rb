# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_502_140_137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'invoices', force: :cascade do |t|
    t.string 'po'
    t.integer 'organization_id', null: false
    t.integer 'customer_id', null: false
    t.datetime 'date', null: false
    t.datetime 'deliver_date', null: false
    t.string 'state'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_invoices_on_order_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'itemable_type', null: false
    t.bigint 'itemable_id', null: false
    t.integer 'quantity', null: false
    t.string 'description', null: false
    t.string 'code', null: false
    t.decimal 'amount', precision: 11, scale: 2, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[itemable_type itemable_id], name: 'index_items_on_itemable'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'po'
    t.integer 'organization_id', null: false
    t.integer 'customer_id', null: false
    t.datetime 'date', null: false
    t.datetime 'deliver_date', null: false
    t.string 'state'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'invoices', 'orders'
end
