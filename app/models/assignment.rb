class Assignment < ActiveRecord::Base
  has_many :students
  has_many :submissions, :through => :students
  belongs_to :instructor
  
  def add_student_keys(keys)
    output_hash = Hash.new
    keys.each do |std_key|
      if self.students.find_by_key(std_key) 
        output_hash[std_key] = "ERROR: key already exists."
      else
        self.students << Student.create!(:key => std_key)
        output_hash[std_key] = "added"
      end
    end
    return output_hash
  end
  
  def remove_student_keys(keys)
    output_hash = Hash.new
    keys.each do |std_key|
      student = self.students.find_by_key(std_key)
      if student
        student.destroy()
        output_hash[std_key] = "removed"
      else
        output_hash[std_key] = "ERROR: key not found"
      end
    end
    return output_hash
  end
  
  def has_student_key?(key)
    self.students.find_by_key(key)
  end
  
  def grading_strategies
    ['max', 'latest']
  end
  
end
