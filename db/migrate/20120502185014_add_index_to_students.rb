class AddIndexToStudents < ActiveRecord::Migration
  def change
    add_index :students, :assignment_id
    add_index :students, :key, :unique => true
  end
end
