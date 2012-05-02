require 'tempfile'

class SubmissionGrader
  @queue = :submissions_queue 
  
  def self.perform(submission_id)
    submission = Submission.find(submission_id)

    #puts "AUTOGRADER::WORKER ID    : " + submission_id.to_s
    #puts "AUTOGRADER::WORKER GRADER: " + submission.student.assignment.autograder
    #puts "AUTOGRADER::WORKER SUBMIS: " + submission.body

    autograder = Tempfile.new("tmp_autograder").write(submission.student.assignment.autograder).chmod(0777).close
    student_code  = Tempfile.new("tmp_student_code").write(submission.body).chmod(0777).close

    #puts "AUTOGRADER::WORKER now I'm gonna run"
    
    submission.output = `#{autograder.path} #{student_code.path}`
    submission.status = 'completed'
    submission.save

    sleep(10)
  end
end
