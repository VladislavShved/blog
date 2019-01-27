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

ActiveRecord::Schema.define(version: 2019_01_27_205429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "header"
    t.string "content"
    t.string "author_ip"
    t.integer "user_id"
    t.decimal "avg_vote", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "marks_count", default: 0, null: false
    t.index ["author_ip"], name: "index_posts_on_author_ip"
    t.index ["avg_vote"], name: "index_posts_on_avg_vote"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "mark"
    t.integer "post_id"
    t.integer "voter_id"
  end

end
