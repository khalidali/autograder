class AddIndexToAssignments < ActiveRecord::Migration
  def change
    add_index :assignments, :instructor_id
  end
end
