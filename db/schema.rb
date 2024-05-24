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

ActiveRecord::Schema[7.1].define(version: 2024_05_24_134226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.integer "total_score", default: 0
    t.jsonb "quiz_data", default: {}
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_evaluations_on_exam_id"
    t.index ["quiz_data"], name: "index_evaluations_on_quiz_data", using: :gin
  end

  create_table "exam_templates", force: :cascade do |t|
    t.string "title"
    t.jsonb "quiz_data", default: {}
    t.datetime "version", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_data"], name: "index_exam_templates_on_quiz_data", using: :gin
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "student_id", null: false
    t.bigint "exam_template_id", null: false
    t.bigint "course_id", null: false
    t.datetime "due_date", precision: nil
    t.jsonb "quiz_data", default: {}
    t.datetime "version", precision: nil
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_exams_on_course_id"
    t.index ["exam_template_id"], name: "index_exams_on_exam_template_id"
    t.index ["quiz_data"], name: "index_exams_on_quiz_data", using: :gin
    t.index ["student_id"], name: "index_exams_on_student_id"
    t.index ["teacher_id"], name: "index_exams_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "evaluations", "exams"
  add_foreign_key "exams", "courses"
  add_foreign_key "exams", "exam_templates"
  add_foreign_key "exams", "users", column: "student_id"
  add_foreign_key "exams", "users", column: "teacher_id"
end
