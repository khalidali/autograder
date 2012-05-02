require 'spec_helper'

describe Assignment do
  # "add some examples to (or delete) #{__FILE__}"
    before :each do
      @hw1 = Factory(:assignment)
    end
  
    describe "add_student_keys" do
       it 'should create a student with the given student key' do
          @hw1.add_student_keys(["s_key1", "s_key2"])
          studenta = @hw1.students.find_by_key('s_key1')
          studenta.key.should == "s_key1"
          studentb = @hw1.students.find_by_key('s_key2')
          studentb.key.should == "s_key2"
          @hw1.add_student_keys(["s_key1"]).should == {"s_key1"=>"ERROR: key already exists."}
       end
    end
    
    describe "remove_Student_keys" do
       it 'should remove a student with the given student key' do
          student = []
          @hw1.add_student_keys(["s_key1", "s_key2"])
          #check students are being added
          @hw1.students.find_by_key('s_key1').key.should == "s_key1"
          @hw1.students.find_by_key('s_key2').key.should == "s_key2"
          #remove students
          @hw1.remove_student_keys(["s_key1", "s_key2"]).should ==  {"s_key1"=>"removed", "s_key2"=>"removed"}
          @hw1.students.where(:key => "s_key1").should == student
          @hw1.students.where(:key => "s_key2").should == student
          @hw1.remove_student_keys(["s_key1"]).should == {"s_key1"=>"ERROR: key not found"} 
       end
    end
    
    describe "has_student_key" do
      it 'should check if student key exists' do
           @hw1.add_student_keys(["s_key1", "s_key2"])
           @hw1.has_student_key?("s_key1").key.should == "s_key1"
           @hw1.has_student_key?("s_key2").key.should == "s_key2"
      end
    end
  
    describe "grading strategy" do
      it 'should check grading_strategies' do
        Assignment.grading_strategies.should ==  ['max', 'latest']
      end
    end
end

