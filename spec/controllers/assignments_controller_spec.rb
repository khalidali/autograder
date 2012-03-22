require 'spec_helper'

describe AssignmentsController do
  describe "Create an Assignment with an Autograder" do
    before(:each) do
      @fake_assignment = Factory(:assignment)
    end
    it 'should create an Assignment instance with the given parameters' do
      Assignment.should_receive(:create!).with("assignment").and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_keys).with(["s_key1", "s_key2"])
      put :create, {:prof_key => "prof_key", :assignment => "assignment", :student_keys => ["s_key1", "s_key2"]}
    end
  end
  
  describe "Addition of student keys per assignment" do
    before(:each) do
      @fake_assignment = Factory(:assignment)
    end
    it 'should find an assignment by id'
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :add_keys, {:id => "id", :student_keys => ["s_key1", "s_key2"]}
    end
      
    it 'should add a student-keys'
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_keys).with(["s_key1", "s_key2"])
      put :add_keys, {:id => "id", :student_keys => ["s_key1", "s_key2"]}
    end 
  end
  
  describe "Deletion of student keys per assignment" do
    before(:each) do
      @fake_assignment = Factory(:assignment)
    end
    it 'should find an assignment by id'
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :delete_keys, {:id => "id", :student_keys => ["s_key1", "s_key2"]}
    end
      
    it 'should add a student-keys'
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:delete_keys).with(["s_key1", "s_key2"])
      put :delete_keys, {:id => "id", :student_keys => ["s_key1", "s_key2"]}
    end 
  end
  
  describe "Retrive a list of submissions by grading-status and student-key per assignemnt" do 
  
  end
  
  describe "Submission for an assignment via a unique key per group/student" do 
  
  end
  
  
  
end
