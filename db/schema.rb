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

ActiveRecord::Schema[7.0].define(version: 2023_06_18_114900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "body"
    t.string "record_type", limit: 255, null: false
    t.bigint "record_id", null: false
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "idx_167682_index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "record_type", limit: 255, null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.timestamptz "created_at", null: false
    t.index ["blob_id"], name: "idx_167689_index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "idx_167689_index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.string "content_type", limit: 255
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", limit: 255
    t.timestamptz "created_at", null: false
    t.string "service_name", limit: 255, null: false
    t.index ["key"], name: "idx_167696_index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", limit: 255, null: false
    t.index ["blob_id", "variation_digest"], name: "idx_167705_index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cross_references", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "reference_id", null: false
    t.string "identifier", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "subject", limit: 255, default: ""
    t.index ["reference_id"], name: "idx_167716_index_cross_references_on_reference_id"
    t.index ["task_id"], name: "idx_167716_index_cross_references_on_task_id"
  end

  create_table "day_types", force: :cascade do |t|
    t.string "abbrev", limit: 255, default: "", null: false
    t.string "description", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["abbrev"], name: "idx_167725_index_day_types_on_abbrev"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "org_unit_id"
    t.string "name", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.bigint "user_id"
    t.bigint "position", default: 0
    t.date "valid_until"
    t.index ["name"], name: "idx_167734_index_lists_on_name"
    t.index ["org_unit_id"], name: "idx_167734_index_lists_on_org_unit_id"
    t.index ["user_id"], name: "idx_167734_index_lists_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.date "date"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["task_id"], name: "idx_167741_index_notes_on_task_id"
    t.index ["user_id"], name: "idx_167741_index_notes_on_user_id"
  end

  create_table "org_units", force: :cascade do |t|
    t.string "name", limit: 255, default: ""
    t.string "ancestry", limit: 255
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.bigint "position", default: 0
    t.date "valid_until"
    t.index ["ancestry"], name: "idx_167746_index_org_units_on_ancestry"
    t.index ["name"], name: "idx_167746_index_org_units_on_name"
  end

  create_table "reference_urls", force: :cascade do |t|
    t.bigint "reference_id", null: false
    t.string "name", limit: 255, default: ""
    t.string "url", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["reference_id"], name: "idx_167765_index_reference_urls_on_reference_id"
  end

  create_table "references", force: :cascade do |t|
    t.string "name", limit: 255, default: ""
    t.string "identifier_name", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["session_id"], name: "idx_167777_index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "idx_167777_index_sessions_on_updated_at"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "state", limit: 255, default: ""
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.bigint "position", default: 0
    t.index ["name"], name: "idx_167784_index_states_on_name"
    t.index ["state"], name: "idx_167784_index_states_on_state"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "subject", limit: 255
    t.date "start"
    t.date "deadline"
    t.date "resubmission"
    t.string "priority", limit: 255
    t.bigint "responsible_id"
    t.bigint "org_unit_id"
    t.bigint "state_id", null: false
    t.bigint "list_id"
    t.boolean "private"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.bigint "user_id"
    t.index ["deadline"], name: "idx_167794_index_tasks_on_deadline"
    t.index ["list_id"], name: "idx_167794_index_tasks_on_list_id"
    t.index ["org_unit_id"], name: "idx_167794_index_tasks_on_org_unit_id"
    t.index ["priority"], name: "idx_167794_index_tasks_on_priority"
    t.index ["responsible_id"], name: "idx_167794_index_tasks_on_responsible_id"
    t.index ["resubmission"], name: "idx_167794_index_tasks_on_resubmission"
    t.index ["start"], name: "idx_167794_index_tasks_on_start"
    t.index ["state_id"], name: "idx_167794_index_tasks_on_state_id"
    t.index ["user_id"], name: "idx_167794_index_tasks_on_user_id"
  end

  create_table "time_accountings", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.string "description", limit: 255, default: ""
    t.date "date"
    t.bigint "duration"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["date"], name: "idx_167803_index_time_accountings_on_date"
    t.index ["task_id"], name: "idx_167803_index_time_accountings_on_task_id"
    t.index ["user_id"], name: "idx_167803_index_time_accountings_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.bigint "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.timestamptz "created_at"
    t.index ["item_type", "item_id"], name: "idx_167809_index_versions_on_item_type_and_item_id"
  end

  create_table "wobauth_authorities", force: :cascade do |t|
    t.bigint "authorizable_id"
    t.string "authorizable_type", limit: 255
    t.bigint "role_id"
    t.bigint "authorized_for_id"
    t.string "authorized_for_type", limit: 255
    t.date "valid_from"
    t.date "valid_until"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["authorizable_id"], name: "idx_167817_index_wobauth_authorities_on_authorizable_id"
    t.index ["authorized_for_id"], name: "idx_167817_index_wobauth_authorities_on_authorized_for_id"
    t.index ["role_id"], name: "idx_167817_index_wobauth_authorities_on_role_id"
  end

  create_table "wobauth_groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
  end

  create_table "wobauth_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.boolean "auto", default: false
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["group_id"], name: "idx_167835_index_wobauth_memberships_on_group_id"
    t.index ["user_id"], name: "idx_167835_index_wobauth_memberships_on_user_id"
  end

  create_table "wobauth_roles", force: :cascade do |t|
    t.string "name", limit: 255
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
  end

  create_table "wobauth_users", force: :cascade do |t|
    t.string "username", limit: 255, default: "", null: false
    t.text "gruppen"
    t.string "sn", limit: 255
    t.string "givenname", limit: 255
    t.string "displayname", limit: 255
    t.string "telephone", limit: 255
    t.string "active_directory_guid", limit: 255
    t.string "userprincipalname", limit: 255
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.timestamptz "reset_password_sent_at"
    t.timestamptz "remember_created_at"
    t.bigint "sign_in_count", default: 0, null: false
    t.timestamptz "current_sign_in_at"
    t.timestamptz "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "title", limit: 255, default: ""
    t.string "position", limit: 255, default: ""
    t.string "department", limit: 255, default: ""
    t.string "company", limit: 255, default: ""
    t.index ["reset_password_token"], name: "idx_167847_index_wobauth_users_on_reset_password_token", unique: true
    t.index ["username"], name: "idx_167847_index_wobauth_users_on_username", unique: true
  end

  create_table "workdays", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.time "work_start"
    t.bigint "pause", default: 0
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.bigint "day_type_id"
    t.string "comment", limit: 255, default: ""
    t.index ["date", "user_id"], name: "idx_167871_index_workdays_on_date_and_user_id", unique: true
    t.index ["day_type_id"], name: "idx_167871_index_workdays_on_day_type_id"
    t.index ["user_id"], name: "idx_167871_index_workdays_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id", on_update: :restrict, on_delete: :restrict
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id", on_update: :restrict, on_delete: :restrict
end
