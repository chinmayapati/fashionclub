# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160714221956) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "first_name",  limit: 255
    t.string   "last_name",   limit: 255
    t.integer  "phone",       limit: 8
    t.string   "email",       limit: 255
    t.string   "address_one", limit: 255
    t.string   "address_two", limit: 255
    t.string   "city",        limit: 255
    t.integer  "zipcode",     limit: 4
    t.string   "country",     limit: 255
    t.text     "additional",  limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "addresses", ["user_id"], name: "fk_user_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "product_id",   limit: 4
    t.integer  "quantity",     limit: 4
    t.integer  "order_placed", limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "carts", ["product_id"], name: "fk_cart_productid", using: :btree
  add_index "carts", ["user_id"], name: "fk_cart_userid", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "fname",           limit: 255
    t.string   "lname",           limit: 255
    t.string   "email",           limit: 255
    t.string   "addr_one",        limit: 255
    t.string   "addr_two",        limit: 255
    t.string   "city",            limit: 255
    t.integer  "zip",             limit: 4
    t.string   "country",         limit: 255
    t.integer  "phone",           limit: 8
    t.string   "product_ids",     limit: 255
    t.string   "quantity",        limit: 255
    t.integer  "shipping_charge", limit: 4
    t.string   "coupon_code",     limit: 255
    t.integer  "total_discount",  limit: 4
    t.float    "tax",             limit: 24
    t.integer  "total",           limit: 4
    t.string   "payment_method",  limit: 255
    t.string   "order_status",    limit: 50,  default: "Processing"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.string   "subcat",     limit: 255
    t.string   "name",       limit: 255
    t.string   "images",     limit: 255
    t.string   "brand",      limit: 255
    t.integer  "price",      limit: 4
    t.integer  "discount",   limit: 4
    t.string   "sizes",      limit: 255,   default: "xxl,xl,m,s"
    t.string   "quantity",   limit: 255
    t.string   "tags",       limit: 255
    t.text     "brief",      limit: 65535
    t.text     "desc",       limit: 65535
    t.float    "rating",     limit: 24
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.integer  "phone",      limit: 8
    t.string   "password",   limit: 255
    t.string   "avatar",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "activated",  limit: 4,   default: 0
    t.string   "token",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "wishlists", ["product_id"], name: "fk_product_id_wishlist", using: :btree
  add_index "wishlists", ["user_id"], name: "fk_user_id_wishlist", using: :btree

  add_foreign_key "addresses", "users", name: "fk_user_id"
  add_foreign_key "carts", "products", name: "fk_cart_productid"
  add_foreign_key "carts", "users", name: "fk_cart_userid"
  add_foreign_key "wishlists", "products", name: "fk_product_id_wishlist"
  add_foreign_key "wishlists", "users", name: "fk_user_id_wishlist"
end
