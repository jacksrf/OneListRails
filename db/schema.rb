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

ActiveRecord::Schema.define(version: 20150209012044) do

  create_table "groups", force: :cascade do |t|
    t.text     "name"
    t.integer  "creator_id"
    t.boolean  "single_list"
    t.boolean  "multi_list"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "email"
    t.text     "name"
  end

  create_table "items", force: :cascade do |t|
    t.text     "name"
    t.text     "url"
    t.text     "price"
    t.integer  "list_id"
    t.boolean  "bought"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.text     "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.text     "name"
    t.integer  "group_id"
    t.integer  "list_id"
    t.boolean  "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "username"
    t.text     "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "first_name"
    t.text     "last_name"
    t.text     "address"
    t.text     "address2"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "email"
    t.text     "phone"
  end

end
