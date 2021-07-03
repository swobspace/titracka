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

ActiveRecord::Schema.define(version: 2021_07_03_095529) do

  create_table "action_text_rich_texts", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cross_references", charset: "utf8", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "reference_id", null: false
    t.string "identifier", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "subject", default: ""
    t.index ["reference_id"], name: "index_cross_references_on_reference_id"
    t.index ["task_id"], name: "index_cross_references_on_task_id"
  end

  create_table "day_types", charset: "utf8", force: :cascade do |t|
    t.string "abbrev", default: "", null: false
    t.string "description", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["abbrev"], name: "index_day_types_on_abbrev"
  end

  create_table "lists", charset: "utf8", force: :cascade do |t|
    t.bigint "org_unit_id"
    t.string "name", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.integer "position", default: 0
    t.index ["name"], name: "index_lists_on_name"
    t.index ["org_unit_id"], name: "index_lists_on_org_unit_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "notes", charset: "utf8", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_notes_on_task_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "org_units", charset: "utf8", force: :cascade do |t|
    t.string "name", default: ""
    t.string "ancestry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", default: 0
    t.index ["ancestry"], name: "index_org_units_on_ancestry"
    t.index ["name"], name: "index_org_units_on_name"
  end

  create_table "reference_urls", charset: "utf8", force: :cascade do |t|
    t.bigint "reference_id", null: false
    t.string "name", default: ""
    t.string "url", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference_id"], name: "index_reference_urls_on_reference_id"
  end

  create_table "references", charset: "utf8", force: :cascade do |t|
    t.string "name", default: ""
    t.string "identifier_name", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", charset: "utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "states", charset: "utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "state", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", default: 0
    t.index ["name"], name: "index_states_on_name"
    t.index ["state"], name: "index_states_on_state"
  end

  create_table "tasks", charset: "utf8", force: :cascade do |t|
    t.string "subject"
    t.date "start"
    t.date "deadline"
    t.date "resubmission"
    t.string "priority"
    t.bigint "responsible_id"
    t.bigint "org_unit_id"
    t.bigint "state_id", null: false
    t.bigint "list_id"
    t.boolean "private"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["deadline"], name: "index_tasks_on_deadline"
    t.index ["list_id"], name: "index_tasks_on_list_id"
    t.index ["org_unit_id"], name: "index_tasks_on_org_unit_id"
    t.index ["priority"], name: "index_tasks_on_priority"
    t.index ["responsible_id"], name: "index_tasks_on_responsible_id"
    t.index ["resubmission"], name: "index_tasks_on_resubmission"
    t.index ["start"], name: "index_tasks_on_start"
    t.index ["state_id"], name: "index_tasks_on_state_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "time_accountings", charset: "utf8", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.string "description", default: ""
    t.date "date"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_time_accountings_on_date"
    t.index ["task_id"], name: "index_time_accountings_on_task_id"
    t.index ["user_id"], name: "index_time_accountings_on_user_id"
  end

  create_table "versions", charset: "utf8", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wobauth_authorities", charset: "utf8", force: :cascade do |t|
    t.bigint "authorizable_id"
    t.string "authorizable_type"
    t.bigint "role_id"
    t.bigint "authorized_for_id"
    t.string "authorized_for_type"
    t.date "valid_from"
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorizable_id"], name: "index_wobauth_authorities_on_authorizable_id"
    t.index ["authorized_for_id"], name: "index_wobauth_authorities_on_authorized_for_id"
    t.index ["role_id"], name: "index_wobauth_authorities_on_role_id"
  end

  create_table "wobauth_groups", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_memberships", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.boolean "auto", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_wobauth_memberships_on_group_id"
    t.index ["user_id"], name: "index_wobauth_memberships_on_user_id"
  end

  create_table "wobauth_roles", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_users", charset: "utf8", force: :cascade do |t|
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

  create_table "workdays", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.time "work_start"
    t.integer "pause", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "day_type_id"
    t.string "comment", default: ""
    t.index ["date", "user_id"], name: "index_workdays_on_date_and_user_id", unique: true
    t.index ["day_type_id"], name: "index_workdays_on_day_type_id"
    t.index ["user_id"], name: "index_workdays_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
