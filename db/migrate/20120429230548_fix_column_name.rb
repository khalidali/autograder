class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :students, :student_key, :key
  end

  def down
  end
end
