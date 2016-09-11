# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160911003821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "kind",                      default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "rare_class",                default: 0
    t.string   "game_preview_file_name"
    t.string   "game_preview_content_type"
    t.integer  "game_preview_file_size"
    t.datetime "game_preview_updated_at"
    t.index ["kind"], name: "index_items_on_kind", using: :btree
    t.index ["rare_class"], name: "index_items_on_rare_class", using: :btree
  end

  create_table "user_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "paint_color"
    t.integer  "certification"
    t.integer  "list"
    t.index ["certification"], name: "index_user_items_on_certification", using: :btree
    t.index ["item_id"], name: "index_user_items_on_item_id", using: :btree
    t.index ["list"], name: "index_user_items_on_list", using: :btree
    t.index ["paint_color"], name: "index_user_items_on_paint_color", using: :btree
    t.index ["user_id"], name: "index_user_items_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "platform"
    t.string   "platform_username"
    t.string   "platform_url"
    t.boolean  "admin",                  default: false
    t.string   "reddit_username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
