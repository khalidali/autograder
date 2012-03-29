require 'spec_helper'

describe Assignment do
  pending "add some examples to (or delete) #{__FILE__}"
  
  describe "add student keys to the assignment" do
    before :each do 
      @assignment = Factory(:assignment)

    end
    it "should Student#create methods for each key passed to it in a list" do
      Student.should_receive(:create).with("s_key1")
      Student.should_receive(:create).with("s_key2")
      @assignment.add_keys(["s_key1", "s_key2"])
    end
  
end
