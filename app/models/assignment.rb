class Assignment < ActiveRecord::Base

  has_many :students
  has_many :submissions, :through => :students
  
  def add_student_keys(student_keys)
    student_keys.each {|std_key| self.students += [Student.create!(:student_key => std_key)]}
  end
  
  def remove_student_keys(student_keys)
    self.students.find_all{|std| student_keys.include?(std.student_key)}.each{|std| std.destroy}
  end
  
  def change_due_date(due_date)
    self.due_date = due_date
  end
  
  def find_by_keys(student_keys)
    self.students.find_all{|std| student_keys.include?(std.student_key)}
  end
  
  def find_by_status(status)
    self.students.find_all{|sta| status.include?(sta.status)}
  end
  
  
end
