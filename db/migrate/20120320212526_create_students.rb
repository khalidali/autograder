class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :key
      t.timestamps
    end
  end
end
