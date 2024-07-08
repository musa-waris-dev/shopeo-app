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

ActiveRecord::Schema[7.0].define(version: 2024_07_08_120109) do
  create_table "catalogue_organizations", force: :cascade do |t|
    t.string "vendor", null: false
    t.string "product_tags"
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_catalogue_organizations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 12, scale: 4, default: "0.0", null: false
    t.decimal "tax", precision: 12, scale: 4
    t.boolean "tax_applicable"
    t.string "barcode"
    t.text "description1"
    t.text "description2"
    t.text "description3"
    t.text "description4"
    t.boolean "published"
    t.decimal "compare_at_price", precision: 12, scale: 4
    t.decimal "unit_price", precision: 12, scale: 4
    t.decimal "cost_per_item", precision: 12, scale: 4
    t.integer "category", default: 0
    t.string "status", default: "offline"
    t.boolean "show_description_2", default: false
    t.boolean "show_description_3", default: false
    t.boolean "show_description_4", default: false
    t.decimal "discount", precision: 12, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variants", force: :cascade do |t|
    t.decimal "price", precision: 10, scale: 2
    t.decimal "cost_price", precision: 10, scale: 2
    t.integer "position"
    t.boolean "track_inventory"
    t.string "sku"
    t.integer "cost_currency"
    t.json "options"
    t.integer "product_id"
    t.string "title"
    t.decimal "discount", precision: 10, scale: 2
    t.integer "option", default: 0
    t.string "option_value"
    t.integer "available"
    t.integer "on_hand"
    t.string "barcode"
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "catalogue_organizations", "products"
end
