class Student < ActiveRecord::Base
  belongs_to :assignment 
  has_many   :submissions 
  
  def add_submission(submission)
    new_submission = Submission.create!(:body => submission, :status => "pending")
    self.submissions << new_submission
    Resque.enqueue(SubmissionGrader, new_submission.id)
    #new_submission.add_to_queue
    return new_submission
  end
end
