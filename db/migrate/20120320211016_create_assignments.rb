class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.datetime :due_date
      t.datetime :hard_deadline
      t.string :grading_strategy
      t.text :autograder
      t.integer :submissions_limit
      t.integer :instructor_id
      t.timestamps
    end
  end
end
