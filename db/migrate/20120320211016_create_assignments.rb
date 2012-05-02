class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.time :due_date
      t.time :late_due_date
      t.text :autograder
      t.integer :instructor_id
      t.timestamps
    end
  end
end
