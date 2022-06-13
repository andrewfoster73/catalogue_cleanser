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

ActiveRecord::Schema[7.0].define(version: 2022_06_13_100016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abbreviations", force: :cascade do |t|
    t.bigint "dictionary_entry_id", null: false
    t.string "letters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dictionary_entry_id"], name: "index_abbreviations_on_dictionary_entry_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "brand_aliases", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "alias"
    t.boolean "confirmed", default: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_aliases_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.boolean "canonical", default: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dictionary_entries", force: :cascade do |t|
    t.string "phrase"
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_measure_aliases", force: :cascade do |t|
    t.bigint "item_measure_id", null: false
    t.string "alias"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_measure_id"], name: "index_item_measure_aliases_on_item_measure_id"
  end

  create_table "item_measures", force: :cascade do |t|
    t.string "name"
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_pack_aliases", force: :cascade do |t|
    t.bigint "item_pack_id", null: false
    t.string "alias"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_pack_id"], name: "index_item_pack_aliases_on_item_pack_id"
  end

  create_table "item_packs", force: :cascade do |t|
    t.string "name"
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_sell_pack_aliases", force: :cascade do |t|
    t.bigint "item_sell_pack_id", null: false
    t.string "alias"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_sell_pack_id"], name: "index_item_sell_pack_aliases_on_item_sell_pack_id"
  end

  create_table "item_sell_packs", force: :cascade do |t|
    t.string "name"
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_duplicates", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "canonical_product_id"
    t.string "action"
    t.decimal "certainty_percentage", precision: 8, scale: 2
    t.integer "mapped_product_id"
    t.decimal "levenshtein_distance", precision: 8, scale: 2
    t.decimal "similarity_score", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_duplicates_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_id"
    t.string "status"
    t.decimal "duplication_certainty", precision: 8, scale: 2
    t.decimal "canonical_certainty", precision: 8, scale: 2
    t.string "action"
    t.datetime "collected_statistics_at", precision: nil
    t.integer "spelling_mistakes"
    t.integer "catalogue_count"
    t.integer "buy_list_count"
    t.integer "priced_catalogue_count"
    t.decimal "average_price", precision: 8, scale: 2
    t.decimal "maximum_price", precision: 8, scale: 2
    t.decimal "minimum_price", precision: 8, scale: 2
    t.decimal "standard_deviation", precision: 8, scale: 2
    t.decimal "variance", precision: 8, scale: 2
    t.integer "inventory_barcodes_count"
    t.integer "inventory_derived_period_balances_count"
    t.integer "inventory_internal_requisition_lines_count"
    t.integer "inventory_stock_counts_count"
    t.integer "inventory_stock_levels_count"
    t.integer "inventory_transfer_items_count"
    t.integer "invoice_line_items_count"
    t.integer "point_of_sale_lines_count"
    t.integer "procurement_products_count"
    t.integer "product_supplier_preferences_count"
    t.integer "purchase_order_line_items_count"
    t.integer "rebates_profile_products_count"
    t.integer "receiving_document_line_items_count"
    t.integer "recipes_count"
    t.integer "requisition_line_items_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "type"
    t.integer "context_id"
    t.string "context_type"
    t.text "description"
    t.jsonb "before"
    t.jsonb "after"
    t.string "status"
    t.string "error"
    t.boolean "requires_approval", default: false
    t.boolean "approved", default: false
    t.datetime "approved_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "abbreviations", "dictionary_entries"
  add_foreign_key "brand_aliases", "brands"
  add_foreign_key "item_measure_aliases", "item_measures"
  add_foreign_key "item_pack_aliases", "item_packs"
  add_foreign_key "item_sell_pack_aliases", "item_sell_packs"
  add_foreign_key "product_duplicates", "products"
end
