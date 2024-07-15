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

ActiveRecord::Schema[7.1].define(version: 2024_07_12_083916) do
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

  create_table "banners", force: :cascade do |t|
    t.string "imageTitle"
    t.integer "imageSortNumber"
    t.boolean "hasPublished"
    t.string "imageURL"
    t.string "transitionURL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donuts", force: :cascade do |t|
    t.string "name"
    t.string "tokenA"
    t.string "tokenB"
    t.string "tokenC"
    t.integer "tokenD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string "ipAddress"
    t.string "browser"
    t.string "os"
    t.string "device"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.string "title"
    t.string "date"
    t.text "body"
    t.string "mainCategory"
    t.boolean "hasPublished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platform_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.integer "user_platforms_id"
    t.integer "platformId", null: false
    t.string "platformName"
    t.string "icon"
    t.string "imageURL"
    t.string "brandColor"
    t.string "titleSentence"
    t.string "titleNotice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_platforms_id"], name: "index_platforms_on_user_platforms_id"
  end

  create_table "privacies", force: :cascade do |t|
    t.text "version"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "terms", force: :cascade do |t|
    t.text "version"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_meta_names", force: :cascade do |t|
    t.integer "userId", null: false
    t.string "userMetaName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["userId"], name: "index_user_meta_names_on_userId"
  end

  create_table "user_platforms", force: :cascade do |t|
    t.integer "userId", null: false
    t.integer "itemId"
    t.integer "platformId", null: false
    t.string "platformName", null: false
    t.string "accountUserId"
    t.string "accountUserName"
    t.string "accountIconImageUrl"
    t.string "accountUserUrl"
    t.string "accountUserSubText"
    t.boolean "hasAccount"
    t.boolean "isBroadCasting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "userId", force: :cascade do |t|
    t.string "hashtag"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashtag"], name: "index_users_on_hashtag", unique: true
    t.index ["userId"], name: "index_users_on_userId", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "version"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "platforms", "user_platforms", column: "user_platforms_id"
  add_foreign_key "user_meta_names", "users", column: "userId", primary_key: "userId"
end
