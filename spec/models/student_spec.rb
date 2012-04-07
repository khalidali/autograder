require 'spec_helper'

describe Student do
  # "add some examples to (or delete) #{__FILE__}"
    before :each do
      @student1 = Factory(:student)
    end
  
    describe "add_submission" do
       it 'should add submission for a student' do
          Submission.find(:all).should == []
          @student1.add_submission('submission1')
          submission = Submission.find_by_body('submission1')
          submission.body.should == 'submission1'
       end
    end
end
