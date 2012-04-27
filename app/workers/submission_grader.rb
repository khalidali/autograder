class SubmissionGrader
  @queue = :submissions_queue 
  
  def self.perform(submission_id)
    submission = Submission.find(submission_id)
    submission.add_to_queue  
  end
end
