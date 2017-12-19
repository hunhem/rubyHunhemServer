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

ActiveRecord::Schema.define(version: 20161226053007) do

  create_table "game_values", force: true do |t|
    t.string   "name"
    t.float    "objectGenerationTimeValue", default: 1.5
    t.float    "objectSpeedValue",          default: 5.0
    t.float    "playerSpeed",               default: 5.0
    t.float    "playerMinSize",             default: 0.8
    t.float    "playerShrinkVal",           default: 0.0357
    t.float    "playerGrowVal",             default: 0.05
    t.float    "playerContGrowVal",         default: 0.05
    t.float    "sEneMinSize",               default: 0.5
    t.float    "sEneMaxSize",               default: 1.5
    t.float    "sEneSpawnFreq",             default: 8.5
    t.float    "sEneSpeedMulti",            default: 1.5
    t.float    "bEneMinSize",               default: 2.5
    t.float    "bEneMaxSize",               default: 4.5
    t.float    "bEneSpawnFreq",             default: 1.0
    t.float    "bEneSpeedMulti",            default: 0.35
    t.float    "triMinSize",                default: 0.5
    t.float    "triMaxSize",                default: 0.9
    t.float    "triSpawnFreq",              default: 0.25
    t.float    "triSpeedMulti",             default: 1.25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.integer  "rank"
    t.integer  "score_id"
    t.string   "account"
    t.integer  "rank_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.string   "account"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "account",            default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.string   "salt"
    t.string   "session"
    t.integer  "high_score",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
