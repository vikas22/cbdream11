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

ActiveRecord::Schema.define(version: 20190530092559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_scores", force: :cascade do |t|
    t.bigint "player_id"
    t.float "starting_11"
    t.float "runs"
    t.float "fours"
    t.float "sixes"
    t.float "str"
    t.float "centuries"
    t.float "duck"
    t.float "wkts"
    t.float "maiden"
    t.float "er"
    t.float "bonus"
    t.float "catches"
    t.float "runout"
    t.float "total"
    t.integer "match_id"
    t.string "match"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_scores_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_players", force: :cascade do |t|
    t.bigint "league_id"
    t.bigint "user_id"
    t.bigint "player_id"
    t.boolean "is_captain"
    t.boolean "is_vice_captain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_team_players_on_league_id"
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["user_id"], name: "index_team_players_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_users_on_league_id"
  end

  add_foreign_key "player_scores", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "team_players", "leagues"
  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "users"
  add_foreign_key "teams", "leagues"
  add_foreign_key "users", "leagues"
end
