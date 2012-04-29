class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :prof_key

      t.timestamps
    end
  end
end
