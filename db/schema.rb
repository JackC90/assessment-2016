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

ActiveRecord::Schema.define(version: 20170130025627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkouts", force: :cascade do |t|
    t.decimal  "amount"
    t.text     "token"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_checkouts_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.decimal  "price"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "paid",       default: false
    t.integer  "duration"
    t.date     "due_date"
    t.index ["product_id"], name: "index_orders_on_product_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.decimal  "price"
    t.integer  "category"
    t.integer  "sale_or_rent"
    t.text     "description"
    t.string   "ages"
    t.integer  "format"
    t.integer  "pages"
    t.date     "publication_date"
    t.string   "publisher"
    t.string   "publication_city"
    t.integer  "language",         default: 0
    t.string   "isbn"
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "title"
    t.integer  "stock",            default: 0
    t.json     "product_images"
    t.integer  "discount",         default: 0
    t.string   "author",           default: "Anonymous"
    t.integer  "duration",         default: 1
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "whatsapp"
    t.string   "phone"
    t.date     "birthdate"
    t.text     "address"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.text     "encrypted_password"
    t.string   "salt"
    t.integer  "role",               default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_foreign_key "checkouts", "orders"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
end
