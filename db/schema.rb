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

ActiveRecord::Schema.define(version: 2018_03_21_145647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_sessions", force: :cascade do |t|
    t.string "term"
    t.string "year"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "closed", default: false
    t.index ["user_id"], name: "index_academic_sessions_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "class_rooms", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_class_rooms_on_department_id"
    t.index ["name"], name: "index_class_rooms_on_name", unique: true
    t.index ["teacher_id"], name: "index_class_rooms_on_teacher_id"
    t.index ["user_id"], name: "index_class_rooms_on_user_id"
  end

  create_table "department_subjects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "department_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_department_subjects_on_department_id"
    t.index ["subject_id"], name: "index_department_subjects_on_subject_id"
    t.index ["user_id"], name: "index_department_subjects_on_user_id"
  end

  create_table "department_teachers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_department_teachers_on_department_id"
    t.index ["user_id"], name: "index_department_teachers_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
    t.index ["user_id"], name: "index_departments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "student_id"
    t.bigint "user_id"
    t.bigint "academic_session_id"
    t.decimal "class_scores", default: "0.0"
    t.decimal "exam_scores", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_session_id"], name: "index_scores_on_academic_session_id"
    t.index ["student_id"], name: "index_scores_on_student_id"
    t.index ["subject_id"], name: "index_scores_on_subject_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "student_subjects", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "subject_id"
    t.bigint "user_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_subjects_on_student_id"
    t.index ["subject_id"], name: "index_student_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_student_subjects_on_teacher_id"
    t.index ["user_id"], name: "index_student_subjects_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "gender"
    t.bigint "user_id"
    t.bigint "teacher_id"
    t.bigint "class_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["class_room_id"], name: "index_students_on_class_room_id"
    t.index ["department_id"], name: "index_students_on_department_id"
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subject_teachers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_subject_teachers_on_subject_id"
    t.index ["user_id"], name: "index_subject_teachers_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "teachers", id: false, force: :cascade do |t|
    t.boolean "is_class_teacher", default: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  add_foreign_key "academic_sessions", "users"
  add_foreign_key "class_rooms", "departments"
  add_foreign_key "class_rooms", "users"
  add_foreign_key "department_subjects", "departments"
  add_foreign_key "department_subjects", "subjects"
  add_foreign_key "department_subjects", "users"
  add_foreign_key "department_teachers", "departments"
  add_foreign_key "department_teachers", "users"
  add_foreign_key "departments", "users"
  add_foreign_key "scores", "academic_sessions"
  add_foreign_key "scores", "students"
  add_foreign_key "scores", "subjects"
  add_foreign_key "scores", "users"
  add_foreign_key "student_subjects", "students"
  add_foreign_key "student_subjects", "subjects"
  add_foreign_key "student_subjects", "users"
  add_foreign_key "students", "class_rooms"
  add_foreign_key "students", "departments"
  add_foreign_key "students", "users"
  add_foreign_key "subject_teachers", "subjects"
  add_foreign_key "subject_teachers", "users"
  add_foreign_key "subjects", "users"
  add_foreign_key "teachers", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "users"
end
