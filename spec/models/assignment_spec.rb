require 'spec_helper'

describe Assignment do
  # "add some examples to (or delete) #{__FILE__}"
    before :each do
      @hw1 = Factory(:assignment)
    end
  
    describe "add_student_keys" do
       it 'should create a student with the given student key' do
          @hw1.add_student_keys(["s_key1", "s_key2"])
          studenta = @hw1.students.find_by_student_key('s_key1')
          studenta.student_key.should == "s_key1"
          studentb = @hw1.students.find_by_student_key('s_key2')
          studentb.student_key.should == "s_key2"
       end
    end
    
    describe "remove_Student_keys" do
       it 'should remove a student with the given student key' do
          student = []
          @hw1.add_student_keys(["s_key1", "s_key2"])
          #check students are being added
          @hw1.students.find_by_student_key('s_key1').student_key.should == "s_key1"
          @hw1.students.find_by_student_key('s_key2').student_key.should == "s_key2"
          #remove students
          @hw1.remove_student_keys(["s_key1", "s_key2"])
          @hw1.students.where(:student_key => "s_key1").should == student
          @hw1.students.where(:student_key => "s_key2").should == student
       end
    end
    
    describe "change_due_date" do
       it 'should change due date' do
         newtime = Time.now
         @hw1.change_due_date(newtime)
         @hw1.due_date.should == newtime
       end
    end
  
end

