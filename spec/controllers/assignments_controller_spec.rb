require 'spec_helper'

describe AssignmentsController do
  #render_views
  
	#################### CREATE #########################
  describe "Create an Assignment with an Autograder" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should create an Assignment instance with the given parameters' do
      Assignment.should_receive(:create).with(:prof_key => "prof_key", :due_date => "due_date").and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "due_date", :student_keys => "[s_key1, s_key2]"}
    end
		it 'should add a list of student keys to the newly created assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "due_date", :student_keys => "[s_key1, s_key2]"}
		end
		it 'should save the assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      post :create, {:prof_key => "prof_key", :due_date => "due_date", :student_keys => "[s_key1, s_key2]"}
		end
		it 'should render the create template' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			post :create, {:prof_key => "prof_key", :due_date => "due_date", :student_keys => "[s_key1, s_key2]"}
			response.should render_template('create')
		end
  end

  #################### add_student_keys ###############
  describe "Addition of student keys per assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find an assignment by id' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :add_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
    end 
    it 'should add a student-keys' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :add_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :add_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
		end
		it 'should render the add student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :add_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
			response.should render_template('add_student_keys')
		end
  end
 
	################ remove_student_keys ################ 
  describe "Deletion of student keys per assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find an assignment by id' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :remove_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
    end 
    it 'should delete a student-keys' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :remove_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :remove_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
		end
		it 'should render the remove student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :remove_student_keys, {:id => "id", :student_keys => "[s_key1, s_key2]"}
			response.should render_template('remove_student_keys')
		end  
  end

	################ change_due_date ###########
  describe "Change due date for assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find an assignment and change due date' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:change_due_date)
      @fake_assignment.stub(:save)
      put :change_due_date, {:id => "id", :due_date=> "04/18/2012"}
    end
		it 'should change the due date' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:change_due_date).with("04/18/2012")
      @fake_assignment.stub(:save)
      put :change_due_date, {:id => "id", :due_date=> "04/18/2012"}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:change_due_date)
      @fake_assignment.should_receive(:save)
      put :change_due_date, {:id => "id", :due_date=> "04/18/2012"}
		end
		it 'should render the change due date template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:change_due_date)
      @fake_assignment.stub(:save)
			put :change_due_date, {:id => "id", :due_date=> "04/18/2012"}
			response.should render_template('change_due_date')
		end
  end
  
	############### submit ###################
	describe "Submit Assignment" do
		before(:each) do
			@fake_assignment = mock(:assignment)
			@submissions_list = [mock(:submission), mock(:submission)]
			@filtered_submissions = [mock(:submission), mock(:submission)]
			@student = mock(:student)
			@student_list = [mock(:student), mock(:student)]
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
		end
		it "should retreive students from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).with("key").and_return(@student)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
		end
		it "should find student by key" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.should_receive(:find_by_student_key).with("key").and_return(@student)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
		end
		it "should add a submission to the student" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.should_receive(:add_submission).with("submission")
			@student.stub(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
		end
		it "should save the changes on student" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.stub(:add_submission)
			@student.should_receive(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
		end
		it "should render submit template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :student_key => "key", :submission => "submission"}
			response.should render_template('submit')
		end
	end

	############# retrieve_submissions_by_status ############
  describe "Retreive list of submissions by grading status" do
		before(:each) do
			@fake_assignment = mock(:assignment)
			@submissions_list = [mock(:submission), mock(:submission)]
			@filtered_submissions = [mock(:submission), mock(:submission)]
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions_by_status, {:id => "id", :status => "status"}
		end
		it "should retreive submissions from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions_by_status, {:id => "id", :status => "status"}
		end
		it "should filter submissions by status" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.should_receive(:find_all_by_status).with("status").and_return(@filtered_submission)
			get :retrieve_submissions_by_status, {:id => "id", :status => "status"}
		end
		it "should render retrieve_submission_by_status template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions_by_status, {:id => "id", :status => "status"}
			response.should render_template('retrieve_submissions_by_status')
		end
		it "should make the results available to the template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions_by_status, {:id => "id", :status => "status"}
			assigns(:submissions).should == @filtered_submissions
		end
	end

	################## retrieve_all_submissions ################
  describe "Retreive list of all submissions" do
		before(:each) do
			@fake_assignment = mock(:assignment)
			@submissions_list = [mock(:submission), mock(:submission)]
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			get :retrieve_all_submissions, {:id => "id"}
		end
		it "should retreive submissions from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:submissions).and_return(@submissions_list)
			get :retrieve_all_submissions, {:id => "id"}
		end
		it "should render retrieve_submission_by_status template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			get :retrieve_all_submissions, {:id => "id"}
			response.should render_template('retrieve_all_submissions')
		end
		it "should make the results available to the template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			get :retrieve_all_submissions, {:id => "id"}
			assigns(:submissions).should == @submissions_list
		end
	end

	############# retrieve_submission_by_student_key ###########
	describe "Retreive list of submissions by student key" do
		before(:each) do
			@fake_assignment = mock(:assignment)
			@submissions_list = [mock(:submission), mock(:submission)]
			@filtered_submissions = [mock(:submission), mock(:submission)]
			@student = mock(:student)
			@student_list = [mock(:student), mock(:student)]
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@filtered_submissions)
			@filtered_submissions.stub(:submissions).and_return(@submissions_list)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
		end
		it "should retreive students from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).with("key").and_return(@student)
			@student.stub(:submissions).and_return(@filtered_submissions)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
		end
		it "should find student by key" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.should_receive(:find_by_student_key).with("key").and_return(@student)
			@student.stub(:submissions).and_return(@filtered_submissions)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
		end
		it "should get submissions from student" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.should_receive(:submissions).and_return(@filtered_submissions)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
		end
		it "should render retrieve_submission_by_status template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.stub(:submissions).and_return(@filtered_submissions)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
			response.should render_template('retrieve_submission_by_student_key')
		end
		it "should make the results available to the template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_student_key).and_return(@student)
			@student.stub(:submissions).and_return(@filtered_submissions)
			get :retrieve_submission_by_student_key, {:id => "id", :student_key => "key"}
			assigns(:submissions).should == @filtered_submissions
		end
	end
end

