class Submission < ActiveRecord::Base
  belongs_to :student
  
  def add_to_queue

    system("./node.rb #{self.id} '#{self.student.assignment.autograder}' '#{self.body}'")
  end
  
end
