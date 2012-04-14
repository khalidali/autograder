class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.time :due_date
      t.string :prof_key
      t.string :autograder

      t.timestamps
    end
  end
end
