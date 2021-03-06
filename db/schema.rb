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

ActiveRecord::Schema.define(version: 2019_04_11_085743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.string "room_name"
    t.bigint "user_id"
    t.bigint "first_user_id"
    t.bigint "second_user_id"
    t.boolean "is_group"
    t.boolean "is_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_user_id"], name: "index_chat_rooms_on_first_user_id"
    t.index ["second_user_id"], name: "index_chat_rooms_on_second_user_id"
    t.index ["user_id"], name: "index_chat_rooms_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "friendlists", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.boolean "is_accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_friendlists_on_recipient_id"
    t.index ["sender_id"], name: "index_friendlists_on_sender_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "sentby_id"
    t.bigint "receivedby_id"
    t.bigint "post_id"
    t.bigint "like_id"
    t.bigint "comment_id"
    t.bigint "notify_type_id"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["like_id"], name: "index_notifications_on_like_id"
    t.index ["notify_type_id"], name: "index_notifications_on_notify_type_id"
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["receivedby_id"], name: "index_notifications_on_receivedby_id"
    t.index ["sentby_id"], name: "index_notifications_on_sentby_id"
  end

  create_table "notify_types", force: :cascade do |t|
    t.string "notify_type"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_media", force: :cascade do |t|
    t.string "media"
    t.string "media_type"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_media_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "content"
    t.string "tags", array: true
    t.string "location"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tags"], name: "index_posts_on_tags", using: :gin
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.bigint "user_id"
    t.string "profile_pic"
    t.string "cover_pic"
    t.string "about"
    t.string "designation"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.string "password"
    t.string "salt"
    t.string "otp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chat_rooms", "users"
  add_foreign_key "chat_rooms", "users", column: "first_user_id"
  add_foreign_key "chat_rooms", "users", column: "second_user_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "friendlists", "users", column: "recipient_id"
  add_foreign_key "friendlists", "users", column: "sender_id"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "users", column: "receivedby_id"
  add_foreign_key "notifications", "users", column: "sentby_id"
  add_foreign_key "post_media", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "user_details", "users"
end
