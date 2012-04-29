class Assignment < ActiveRecord::Base
  has_many :students
  has_many :submissions, :through => :students
  
  def add_student_keys(student_keys)
    duplicates = []
    student_keys.each do |std_key|
      if self.students.find_by_student_key(std_key) 
          duplicates << std_key
      else
          self.students << Student.create!(:student_key => std_key)
      end
    end
    return student_keys - duplicates, duplicates
  end
  
  def remove_student_keys(student_keys)
    self.students.find_all{|std| student_keys.include?(std.student_key)}.each{|std| std.destroy}
  end
  
  def change_due_date(due_date)
    self.due_date = due_date
  end
end
