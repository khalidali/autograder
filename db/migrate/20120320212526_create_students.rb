class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :key
      t.integer :assignment_id
      t.timestamps
    end
  end
end
