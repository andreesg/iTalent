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

ActiveRecord::Schema.define(version: 20140409152123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.datetime "date_limit"
    t.integer  "num_attendings"
    t.integer  "num_invitations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_start"
  end

  create_table "publications", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "publications", ["creator_id"], name: "index_publications_on_creator_id", using: :btree

  create_table "publications_tags", id: false, force: true do |t|
    t.integer "publication_id"
    t.integer "tag_id"
  end

  add_index "publications_tags", ["publication_id"], name: "index_publications_tags_on_publication_id", using: :btree
  add_index "publications_tags", ["tag_id"], name: "index_publications_tags_on_tag_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "status"
  end

  add_index "subscriptions", ["tag_id"], name: "index_subscriptions_on_tag_id", using: :btree
  add_index "subscriptions", ["user_id", "tag_id"], name: "index_subscriptions_on_user_id_and_tag_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",            limit: 30
    t.integer  "num_subscribers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
