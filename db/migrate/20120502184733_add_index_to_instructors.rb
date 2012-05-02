class AddIndexToInstructors < ActiveRecord::Migration
  def change
    add_index :instructors, :key
  end
end
