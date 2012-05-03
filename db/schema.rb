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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120502185301) do

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.datetime "due_date"
    t.datetime "hard_deadline"
    t.string   "grading_strategy"
    t.text     "autograder"
    t.integer  "submissions_limit"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["instructor_id"], :name => "index_assignments_on_instructor_id"

  create_table "instructors", :force => true do |t|
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructors", ["key"], :name => "index_instructors_on_key"

  create_table "students", :force => true do |t|
    t.string   "key"
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["assignment_id"], :name => "index_students_on_assignment_id"
  add_index "students", ["key"], :name => "index_students_on_key"

  create_table "submissions", :force => true do |t|
    t.text     "body"
    t.text     "output"
    t.string   "status"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["status"], :name => "index_submissions_on_status"

end
