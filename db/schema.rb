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

ActiveRecord::Schema.define(version: 20190625074932) do

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "plan_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_favorites_on_plan_id", using: :btree
    t.index ["user_id", "plan_id"], name: "index_favorites_on_user_id_and_plan_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "favorites_count", default: 0, null: false
    t.index ["user_id"], name: "index_plans_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id", using: :btree
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "plans", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
end
