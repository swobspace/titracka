# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_26_170037) do

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wobauth_authorities", force: :cascade do |t|
    t.integer "authorizable_id"
    t.string "authorizable_type"
    t.integer "role_id"
    t.integer "authorized_for_id"
    t.string "authorized_for_type"
    t.date "valid_from"
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorizable_id"], name: "index_wobauth_authorities_on_authorizable_id"
    t.index ["authorized_for_id"], name: "index_wobauth_authorities_on_authorized_for_id"
    t.index ["role_id"], name: "index_wobauth_authorities_on_role_id"
  end

  create_table "wobauth_groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.boolean "auto", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_wobauth_memberships_on_group_id"
    t.index ["user_id"], name: "index_wobauth_memberships_on_user_id"
  end

  create_table "wobauth_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.text "gruppen"
    t.string "sn"
    t.string "givenname"
    t.string "displayname"
    t.string "telephone"
    t.string "active_directory_guid"
    t.string "userprincipalname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", default: ""
    t.string "position", default: ""
    t.string "department", default: ""
    t.string "company", default: ""
    t.index ["reset_password_token"], name: "index_wobauth_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_wobauth_users_on_username", unique: true
  end

end
