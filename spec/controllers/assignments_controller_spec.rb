require 'spec_helper'

describe AssignmentsController do
  
	#################### CREATE #########################
  describe "Create an Assignment with an a list of Student Keys" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should create an Assignment instance with the given parameters' do
			@due_date = "Sun Apr 29 15:30:23".to_time
			@hard_deadline = "Sun Apr 29 15:30:23".to_time
      Assignment.should_receive(:create).with(:prof_key => "prof_key", :due_date => @due_date, :hard_deadline => @hard_deadline, :autograder => nil).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :student_keys => "[s_key1, s_key2]", :format => :json}
    end
		it 'should add a list of student keys to the newly created assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :student_keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should save the assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :student_keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should render the create template' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :student_keys => "[s_key1, s_key2]", :format => :json}
			response.should render_template('create')
		end
  end
  
  describe "Create an Assignment with an Autograder" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @content = mock(:string)
      @autograder = fixture_file_upload('/files/temp.rb')
      @path = mock(:string)
      @file = mock(:file)
    end
    it 'should get the file path from the params' do
			@autograder.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :autograder => @autograder, :format => :json}
		end
		it 'should read the file content' do
			@autograder.stub_chain(:tempfile, :path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :autograder => @autograder, :format => :json}
		end
		it 'should create an Assignment instance with the given parameters' do
      @due_date = "Sun Apr 29 15:30:23".to_time
			@hard_deadline = "Sun Apr 29 15:30:23".to_time
      @autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
			Assignment.should_receive(:create).with(:prof_key => "prof_key", :due_date => @due_date, :hard_deadline => @hard_deadline, :autograder => @content).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :autograder => @autograder, :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.should_receive(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :autograder => @autograder, :format => :json}
		end
		it 'should render the create template' do
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      post :create, {:prof_key => "prof_key", :due_date => "Sun Apr 29 15:30:23", :hard_deadline => "Sun Apr 29 15:30:23", :autograder => @autograder, :format => :json}
			response.should render_template('create')
		end
  end

	#################### get_autograder ###############
  describe "Get the autograder for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :get_autograder, {:id => "id", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      put :get_autograder, {:id => "id", :format => :json}
			response.should render_template('get_autograder')
		end
  end  

  #################### set_autograder ###############
  describe "Set the Autograder for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @content = mock(:string)
      @autograder = fixture_file_upload('/files/temp.rb')
      @path = mock(:string)
      @file = mock(:file)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
    end
    it 'should get the file path from the params' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
		end
		it 'should read the file content' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
      @fake_assignment.stub(:autograder=).with(@content)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
		end
		it 'should add an autograder to the assignment' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_assignment.should_receive(:autograder=).with(@content)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
		end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.should_receive(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
		end
		it 'should render the create template' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id", :autograder => @autograder, :format => :json}
			response.should render_template('set_autograder')
		end
  end
	describe "Set the Autograder with no autograder param" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			put :set_autograder, {:id => "id", :format => :json}
			response.should render_template(:text => 'required param \'autograder\' missing.')
		end
	end
	
	#################### get_due_date ###############
  describe "Get the due_date for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :get_due_date, {:id => "id", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      put :get_due_date, {:id => "id", :format => :json}
			response.should render_template('get_due_date')
		end
  end
	
	################ set_due_date ###########
  describe "Set due date for assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find an assignment and change due date' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:due_date=)
      @fake_assignment.stub(:save)
      put :set_due_date, {:id => "id", :due_date => "Sun Apr 29 15:30:23", :format => :json}
    end
		it 'should change the due date' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@due_date = "Sun Apr 29 15:30:23".to_time
      @fake_assignment.should_receive(:due_date=).with(@due_date)
      @fake_assignment.stub(:save)
      put :set_due_date, {:id => "id", :due_date => "Sun Apr 29 15:30:23", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:due_date=)
      @fake_assignment.should_receive(:save)
      put :set_due_date, {:id => "id", :due_date => "Sun Apr 29 15:30:23", :format => :json}
		end
		it 'should render the correct template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:due_date=)
      @fake_assignment.stub(:save)
			put :set_due_date, {:id => "id", :due_date => "Sun Apr 29 15:30:23", :format => :json}
			response.should render_template('set_due_date')
		end
  end
	describe "Set the due date with no due date param" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			put :set_due_date, {:id => "id", :format => :json}
			response.should render_template(:text => 'required param \'due_date\' missing.')
		end
	end 

	#################### get_hard_deadline ###############
  describe "Get the hard_deadline for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :get_hard_deadline, {:id => "id", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      put :get_hard_deadline, {:id => "id", :format => :json}
			response.should render_template('get_hard_deadline')
		end
  end
	
	################ set_hard_deadline ###########
  describe "Set late due date for assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
    end
    it 'should find an assignment and change due date' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.stub(:save)
      put :set_hard_deadline, {:id => "id", :hard_deadline => "Sun Apr 29 15:30:23", :format => :json}
    end
		it 'should change the due date' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@hard_deadline = "Sun Apr 29 15:30:23".to_time
      @fake_assignment.should_receive(:hard_deadline=).with(@hard_deadline)
      @fake_assignment.stub(:save)
      put :set_hard_deadline, {:id => "id", :hard_deadline => "Sun Apr 29 15:30:23", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.should_receive(:save)
      put :set_hard_deadline, {:id => "id", :hard_deadline => "Sun Apr 29 15:30:23", :format => :json}
		end
		it 'should render the correct template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.stub(:save)
			put :set_hard_deadline, {:id => "id", :hard_deadline => "Sun Apr 29 15:30:23", :format => :json}
			response.should render_template('set_hard_deadline')
		end
  end
	describe "Set the late due date with no late due date param" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			put :set_hard_deadline, {:id => "id", :format => :json}
			response.should render_template(:text => 'required param \'hard_deadline\' missing.')
		end
	end  

	#################### list_student_keys ###############
  describe "list student keys for a givin assignment" do
    before(:each) do
      @assignment = mock(:assignment)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@assignment)
			@assignment.stub(:students)
      put :list_student_keys, {:id => "id", :format => :json}
		end
		it "should retrieve students from assignment" do
			Assignment.stub(:find_by_id).and_return(@assignment)
			@assignment.should_receive(:students)
      put :list_student_keys, {:id => "id", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@assignment)
			@assignment.stub(:students)
      put :list_student_keys, {:id => "id", :format => :json}
			response.should render_template('list_student_keys')
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
      put :add_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
    end 
    it 'should add a student-keys' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :add_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :add_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should render the add student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :add_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
			response.should render_template('add_student_keys')
		end
  end
	describe "Add student keys with no keys param" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			put :add_student_keys, {:id => "id", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'keys\' missing.')
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
      put :remove_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
    end 
    it 'should delete a student-keys' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :remove_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :remove_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should render the remove student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :remove_student_keys, {:id => "id", :keys => "[s_key1, s_key2]", :format => :json}
			response.should render_template('remove_student_keys')
		end  
  end
	describe "Remove student keys with no keys param" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			put :remove_student_keys, {:id => "id", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'keys\' missing.')
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
			@path = mock(:string)
      @content = mock(:string)
      @submission = fixture_file_upload('/files/temp.rb')
      @file = mock(:file)
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should retreive students from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).with("key").and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should find student by key" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.should_receive(:find_by_key).with("key").and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should get the file path from the params" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).with("key").and_return(@student)
			@submission.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should read content from the file" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).with("key").and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should add a submission to the student" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
			@student.should_receive(:add_submission).with(@content)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should save the changes on student" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.should_receive(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should render submit template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
			response.should render_template('submit')
		end
	end
	describe "submit with no keys param" do
		it "should render an error" do 
			@student = mock(:student)
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub_chain(:students, :find_by_key).and_return(@student)
			put :submit, {:id => "id", :key => "key", :format => :json}
			response.should render_template(:text => 'ERROR: student key doesn\'t exist and required param \'submission\' missing.')
		end
	end 
	describe "submit and student does not exist" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@students = [mock(:student), mock(:student)]
			@fake_assignment.stub(:students).and_return(@students)
			@students.stub(:find_by_key).and_return(nil)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
			response.should render_template(:text => 'ERROR: student key doesn\'t exist.')
		end
	end
	describe "submit with no keys param and student does not exist" do
		it "should render an error" do 
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@students = [mock(:student), mock(:student)]
			@fake_assignment.stub(:students).and_return(@students)
			@students.stub(:find_by_key).and_return(nil)
			put :submit, {:id => "id", :key => "key", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'submission\' missing.')
		end
	end


	############# retrieve_submissions ############
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
			get :retrieve_submissions, {:id => "id", :status => "status", :format => :json}
		end
		it "should retreive submissions from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :status => "status", :format => :json}
		end
		it "should filter submissions by status" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.should_receive(:find_all_by_status).with("status").and_return(@filtered_submission)
			get :retrieve_submissions, {:id => "id", :status => "status", :format => :json}
		end
		it "should render retrieve_submission_by_status template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :status => "status", :format => :json}
			response.should render_template('retrieve_submissions')
		end
		it "should make the results available to the template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :status => "status", :format => :json}
			assigns(:submissions).should == @filtered_submissions
		end
	end
end

