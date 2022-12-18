# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_18_095536) do
  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.text "colors", default: "{\"red\":0,\"orange\":3,\"yellow\":7}"
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "public_folders", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.text "colors", default: "{\"red\":0,\"orange\":3,\"yellow\":7}"
    t.text "members", default: "[]"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_public_folders_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.boolean "done"
    t.integer "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline"
    t.string "done_by", default: ""
    t.integer "public_folder_id"
    t.index ["folder_id"], name: "index_tasks_on_folder_id"
    t.index ["public_folder_id"], name: "index_tasks_on_public_folder_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  add_foreign_key "folders", "users"
  add_foreign_key "public_folders", "users"
  add_foreign_key "tasks", "folders"
  add_foreign_key "tasks", "public_folders"
end
