class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :key

      t.timestamps
    end
  end
end
