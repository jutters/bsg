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

ActiveRecord::Schema.define(version: 20150618183624) do

  create_table "shops", force: true do |t|
    t.string   "name"
    t.string   "site_url"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "price_segment_low",               default: false
    t.boolean  "price_segment_middle",            default: false
    t.boolean  "price_segment_high",              default: false
    t.boolean  "locale_de_shop",                  default: false
    t.boolean  "locale_foreign_shop_de_website",  default: false
    t.boolean  "locale_foreign_shop_de_delivery", default: false
    t.boolean  "brand_type_single",               default: false
    t.boolean  "brand_type_multi",                default: false
    t.boolean  "shop_type_women_fashion",         default: false
    t.boolean  "shop_type_men_fashion",           default: false
    t.boolean  "shop_type_interior_design",       default: false
    t.boolean  "insider_tip",                     default: false
    t.string   "image"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
