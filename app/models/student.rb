class Student < ActiveRecord::Base

  belongs_to :assignment 
  has_many   :submissions 
  
  
  def add_submission(submission)
    new_submission = Submission.create!(:body => submission, :status => "pending")
    self.submissions << new_submission
    new_submission.add_to_queue
  end
  
  def find_by_student_keys(student_keys)
  end
  
end
