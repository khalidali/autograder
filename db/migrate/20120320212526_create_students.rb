class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :student_key
      t.integer :assignment_id
      t.timestamps
    end
  end
end
