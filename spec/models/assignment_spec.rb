require 'spec_helper'

describe Assignment do
  # "add some examples to (or delete) #{__FILE__}"
    before :each do
      @hw1 = Factory(:assignment)
    end
  
    describe "add_student_keys" do
       it 'should create a student with the given student key' do
          @hw1.add_student_keys(["s_key1", "s_key2"])
          student1 = @hw1.students.where(:student_key => "s_key1")
          student1.student_key.should == "s_key1"
          student2 = @hw1.students.where(:student_key => "s_key2")
          student2.student_key.should == "s_key2"
       end
    end
    
    describe "remove_Student_keys" do
       it 'should remove a student with the given student key' do
          student = []
          @hw1.add_student_keys(["s_key1", "s_key2"])
          @hw1.remove_student_keys(["s_key1", "s_key2"])
          student1 = @hw1.students.where(:student_key => "s_key1")
          student1.should == student
          student2 = @hw1.students.where(:student_key => "s_key2")
          student2.should == student
       end
    end
    
    describe "change_due_date" do
       it 'should change due date' do
         newtime = Time.now
         @hw1.change_due_date(newtime)
         @hw1.due_date.should == newtime
       end
    end
    
    describe "find_by_keys" do
      it 'should find submission by student keys' do
        @hw1.add_student_keys(["s_key1", "s_key2"])
        #need to finish create submission by student first
      end
    end
    
    describe "find_by_status" do
      it 'should find submission by status' do
        #need to finish create submission by student first  
      end
    end
  
end

