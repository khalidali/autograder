require 'spec_helper'

describe Student do
  # "add some examples to (or delete) #{__FILE__}"
    before :each do
      @student1 = Factory(:student)
      @submit = Factory(:submission)
      @assignment = Factory(:assignment)
      ResqueSpec.reset!
    end
  
    describe "add_submission" do
       it 'should add submission for a student' do
          @student1.add_submission('submission1')
          SubmissionGrader.should have_queue_size_of(1)
          submission = Submission.find_by_body('submission1')
          submission.body.should == 'submission1'
          submission.status.should == 'dequeued'
       end
    end
end
