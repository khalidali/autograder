class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.time :due_date
      t.time :hard_deadline
      t.string :prof_key
      t.string :grading_strategy
      t.text :autograder
      t.integer :instructor_id
      t.integer :submissions_limit
      t.timestamps
    end
  end
end
