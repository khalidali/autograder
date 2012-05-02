class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.time :due_date
      t.time :hard_deadline
      t.string :prof_key
      t.text :autograder
      t.integer :professor_id
      t.timestamps
    end
  end
end
