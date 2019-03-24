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

ActiveRecord::Schema.define(version: 2019_03_24_123339) do

  create_table "nodes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "parent_id", default: 0
    t.integer "tree_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "depth", default: 0
    t.index ["depth"], name: "index_nodes_on_depth"
    t.index ["tree_id"], name: "index_nodes_on_tree_id"
  end

  create_table "trees", force: :cascade do |t|
    t.text "json_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
