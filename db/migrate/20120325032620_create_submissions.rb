class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :body
      t.text :output
      t.string :status
      t.integer :student_id
      t.timestamps
    end
  end
end
