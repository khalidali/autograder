class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :body
      t.string :output
      t.string :status
      t.integer :student_id
      t.timestamps
    end
  end
end
