class Student < ActiveRecord::Base

  belongs_to :assignment 
  has_many   :submissions 
  
  def add_submission(submission)
    self.submissions << Submission.create!(:body => submission, :status => "pending")
  end
  
  def find_by_student_keys(student_keys)
  end
  
end
