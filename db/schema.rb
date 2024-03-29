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

ActiveRecord::Schema[7.0].define(version: 2023_01_09_142945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "data_source_type", ["import", "manual"]
  create_enum "product_action", ["delete", "map", "none", "pending"]
  create_enum "product_issue_status", ["pending", "confirmed", "ignored", "fixed"]
  create_enum "task_status", ["pending", "processing", "complete", "error"]

  create_table "abbreviations", force: :cascade do |t|
    t.bigint "dictionary_entry_id", null: false
    t.string "letters", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dictionary_entry_id"], name: "index_abbreviations_on_dictionary_entry_id"
    t.index ["letters"], name: "index_abbreviations_on_letters", unique: true
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
    t.index ["action"], name: "index_audits_on_action"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "brand_aliases", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "alias", null: false
    t.boolean "confirmed", default: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.index ["alias"], name: "index_brand_aliases_on_alias", unique: true
    t.index ["brand_id"], name: "index_brand_aliases_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "canonical", default: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.integer "brand_aliases_count", default: 0, null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dictionary_entries", force: :cascade do |t|
    t.string "phrase", null: false
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "abbreviations_count", default: 0, null: false
    t.index ["phrase"], name: "index_dictionary_entries_on_phrase", unique: true
  end

  create_table "item_measure_aliases", force: :cascade do |t|
    t.bigint "item_measure_id", null: false
    t.string "alias", null: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.index ["alias"], name: "index_item_measure_aliases_on_alias", unique: true
    t.index ["item_measure_id"], name: "index_item_measure_aliases_on_item_measure_id"
  end

  create_table "item_measures", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.integer "item_measure_aliases_count", default: 0, null: false
    t.index ["name"], name: "index_item_measures_on_name", unique: true
  end

  create_table "item_pack_aliases", force: :cascade do |t|
    t.bigint "item_pack_id", null: false
    t.string "alias", null: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.index ["alias"], name: "index_item_pack_aliases_on_alias", unique: true
    t.index ["item_pack_id"], name: "index_item_pack_aliases_on_item_pack_id"
  end

  create_table "item_packs", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.integer "item_pack_aliases_count", default: 0, null: false
    t.index ["name"], name: "index_item_packs_on_name", unique: true
  end

  create_table "item_sell_pack_aliases", force: :cascade do |t|
    t.bigint "item_sell_pack_id", null: false
    t.string "alias", null: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.index ["alias"], name: "index_item_sell_pack_aliases_on_alias", unique: true
    t.index ["confirmed"], name: "index_item_sell_pack_aliases_on_confirmed"
    t.index ["item_sell_pack_id"], name: "index_item_sell_pack_aliases_on_item_sell_pack_id"
  end

  create_table "item_sell_packs", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "canonical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.integer "item_sell_pack_aliases_count", default: 0, null: false
    t.index ["canonical"], name: "index_item_sell_packs_on_canonical"
    t.index ["name"], name: "index_item_sell_packs_on_name", unique: true
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

  create_table "product_issues", force: :cascade do |t|
    t.bigint "product_id"
    t.string "type"
    t.string "test_attribute"
    t.string "resolution_task_type"
    t.string "resolution_suggested_replacement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "product_issue_status"
    t.bigint "resolution_task_id"
    t.bigint "product_translation_id"
    t.index ["product_id"], name: "index_product_issues_on_product_id"
    t.index ["product_translation_id"], name: "index_product_issues_on_product_translation_id"
    t.index ["resolution_task_id"], name: "index_product_issues_on_resolution_task_id"
  end

  create_table "product_translations", force: :cascade do |t|
    t.bigint "product_id"
    t.string "locale"
    t.text "item_description"
    t.string "brand"
    t.decimal "item_size", precision: 19, scale: 4
    t.string "item_measure"
    t.string "item_pack_name"
    t.decimal "item_sell_quantity", precision: 19, scale: 4
    t.string "item_sell_pack_name"
    t.boolean "valid_locale", default: false, null: false
    t.boolean "valid_translations", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "external_product_translation_id"
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.index ["external_product_translation_id"], name: "index_product_translations_on_external_product_translation_id"
    t.index ["product_id"], name: "index_product_translations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "external_product_id", null: false
    t.decimal "duplication_certainty", precision: 8, scale: 2
    t.decimal "canonical_certainty", precision: 8, scale: 2
    t.boolean "canonical", default: false
    t.datetime "collected_usage_at", precision: nil
    t.integer "catalogue_count"
    t.integer "buy_list_count"
    t.integer "priced_catalogue_count"
    t.decimal "average_price", precision: 19, scale: 2
    t.decimal "maximum_price", precision: 19, scale: 2
    t.decimal "minimum_price", precision: 19, scale: 2
    t.decimal "standard_deviation", precision: 19, scale: 2
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
    t.enum "action", enum_type: "product_action"
    t.text "item_description"
    t.string "brand"
    t.decimal "item_size"
    t.string "item_measure"
    t.string "item_pack_name"
    t.decimal "item_sell_quantity"
    t.string "item_sell_pack_name"
    t.decimal "volume_in_litres"
    t.bigint "category_id"
    t.text "category_path"
    t.string "image_file_name"
    t.datetime "image_updated_at", precision: nil
    t.datetime "last_synced_at", precision: nil
    t.string "locale"
    t.enum "data_source", default: "manual", enum_type: "data_source_type"
    t.integer "product_duplicates_count", default: 0, null: false
    t.integer "product_issues_count", default: 0, null: false
    t.integer "product_issues_outstanding_count", default: 0, null: false
    t.integer "product_translations_count", default: 0, null: false
    t.datetime "discarded_at"
    t.integer "credit_note_lines_count"
    t.integer "linked_products_count"
    t.datetime "collected_pricing_at", precision: nil
    t.decimal "median_price", precision: 19, scale: 2
    t.integer "price_count"
    t.string "price_country"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["discarded_at"], name: "index_products_on_discarded_at"
    t.index ["external_product_id"], name: "index_products_on_external_product_id", unique: true
    t.index ["item_description"], name: "index_products_item_description_gin", opclass: :gin_trgm_ops, using: :gin
    t.check_constraint "average_price >= 0::numeric", name: "average_price_check"
    t.check_constraint "buy_list_count >= 0", name: "buy_list_count_check"
    t.check_constraint "canonical_certainty >= 0::numeric", name: "canonical_certainty_check"
    t.check_constraint "catalogue_count >= 0", name: "catalogue_count_check"
    t.check_constraint "credit_note_lines_count >= 0", name: "credit_note_lines_count_check"
    t.check_constraint "duplication_certainty >= 0::numeric", name: "duplication_certainty_check"
    t.check_constraint "inventory_barcodes_count >= 0", name: "inventory_barcodes_count_check"
    t.check_constraint "inventory_derived_period_balances_count >= 0", name: "inventory_derived_period_balances_count_check"
    t.check_constraint "inventory_internal_requisition_lines_count >= 0", name: "inventory_internal_requisition_lines_count_check"
    t.check_constraint "inventory_stock_counts_count >= 0", name: "inventory_stock_counts_count_check"
    t.check_constraint "inventory_stock_levels_count >= 0", name: "inventory_stock_levels_count_check"
    t.check_constraint "inventory_transfer_items_count >= 0", name: "inventory_transfer_items_count_check"
    t.check_constraint "invoice_line_items_count >= 0", name: "invoice_line_items_count_check"
    t.check_constraint "linked_products_count >= 0", name: "linked_products_count_check"
    t.check_constraint "maximum_price >= 0::numeric", name: "maximum_price_check"
    t.check_constraint "median_price >= 0::numeric", name: "median_price_check"
    t.check_constraint "minimum_price >= 0::numeric", name: "minimum_price_check"
    t.check_constraint "point_of_sale_lines_count >= 0", name: "point_of_sale_lines_count_check"
    t.check_constraint "price_count >= 0", name: "price_count_check"
    t.check_constraint "procurement_products_count >= 0", name: "procurement_products_count_check"
    t.check_constraint "product_supplier_preferences_count >= 0", name: "product_supplier_preferences_count_check"
    t.check_constraint "purchase_order_line_items_count >= 0", name: "purchase_order_line_items_count_check"
    t.check_constraint "rebates_profile_products_count >= 0", name: "rebates_profile_products_count_check"
    t.check_constraint "receiving_document_line_items_count >= 0", name: "receiving_document_line_items_count_check"
    t.check_constraint "recipes_count >= 0", name: "recipes_count_check"
    t.check_constraint "requisition_line_items_count >= 0", name: "requisition_line_items_count_check"
    t.check_constraint "standard_deviation >= 0::numeric", name: "standard_deviation_check"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "type"
    t.integer "context_id"
    t.string "context_type"
    t.text "description"
    t.jsonb "before"
    t.jsonb "after"
    t.string "error"
    t.boolean "requires_approval", default: false
    t.boolean "approved", default: false
    t.datetime "approved_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "backtrace"
    t.enum "status", enum_type: "task_status"
    t.bigint "approved_by_id"
    t.string "product_issue_type"
    t.bigint "product_issue_id"
    t.index ["approved_by_id"], name: "index_tasks_on_approved_by_id"
    t.index ["product_issue_type", "product_issue_id"], name: "index_tasks_on_product_issue"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "provider"
    t.string "uid"
    t.string "picture_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
    t.string "country_alpha2"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "abbreviations", "dictionary_entries"
  add_foreign_key "brand_aliases", "brands"
  add_foreign_key "item_measure_aliases", "item_measures"
  add_foreign_key "item_pack_aliases", "item_packs"
  add_foreign_key "item_sell_pack_aliases", "item_sell_packs"
  add_foreign_key "product_duplicates", "products"
end
