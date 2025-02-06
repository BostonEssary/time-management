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

ActiveRecord::Schema[7.2].define(version: 2025_02_06_040359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concentrates", force: :cascade do |t|
    t.string "strain"
    t.string "category"
    t.bigint "brand_id", null: false
    t.string "name"
    t.float "thc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_concentrates_on_brand_id"
  end

  create_table "edibles", force: :cascade do |t|
    t.string "name"
    t.string "strain"
    t.integer "mg_per_serving"
    t.bigint "brand_id", null: false
    t.string "food_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_edibles_on_brand_id"
  end

  create_table "effects", force: :cascade do |t|
    t.text "description"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_effects_on_name", unique: true
  end

  create_table "flowers", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.float "thc"
    t.string "strain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_flowers_on_brand_id"
    t.index ["name", "brand_id"], name: "index_flowers_on_name_and_brand_id", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "followee_id"
    t.bigint "follower_id"
    t.index ["followee_id", "follower_id"], name: "index_follows_on_followee_id_and_follower_id", unique: true
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "pre_rolls", force: :cascade do |t|
    t.string "name"
    t.string "strain"
    t.string "thc"
    t.bigint "brand_id", null: false
    t.boolean "infused"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_pre_rolls_on_brand_id"
  end

  create_table "product_effects", force: :cascade do |t|
    t.bigint "effect_id", null: false
    t.string "effectable_type", null: false
    t.bigint "effectable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effect_id", "effectable_type", "effectable_id"], name: "index_product_effects_uniqueness", unique: true
    t.index ["effect_id"], name: "index_product_effects_on_effect_id"
    t.index ["effectable_type", "effectable_id"], name: "index_product_effects_on_effectable"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.string "ratable_type", null: false
    t.bigint "ratable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ratable_type", "ratable_id"], name: "index_ratings_on_ratable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.string "username"
    t.string "experience_level"
    t.string "consumption_preferences", default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "concentrates", "brands"
  add_foreign_key "edibles", "brands"
  add_foreign_key "flowers", "brands"
  add_foreign_key "follows", "users", column: "followee_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "pre_rolls", "brands"
  add_foreign_key "product_effects", "effects"
end
