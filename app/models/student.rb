class Student < ActiveRecord::Base
  belongs_to :assignment 
  has_many   :submissions
  validates_uniqueness_of :key
  
  def add_submission(submission)
    new_submission = Submission.create!(:body => submission, :status => "pending")
    self.submissions << new_submission
    Resque.enqueue(SubmissionGrader, new_submission.id)
    if self.assignment.grading_strategy == 'latest' then
      # dequeue all previous submissions
      self.submissions.each do |s|
        if s.id != new_submission.id then
          Resque.dequeue(SubmissionGrader, s.id)
          s.status = "dequeued"
          s.save
        end
      end
    end
    return new_submission
  end
end
