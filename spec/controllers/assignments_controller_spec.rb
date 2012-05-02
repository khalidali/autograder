require 'spec_helper'

describe AssignmentsController do

	#################### CREATE #########################
  describe "Create an Assignment with an a list of Student Keys" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      @assignments = [mock(:assignment), mock(:assignment)]
      @fake_instructor = mock(:instructor)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
    end
    it 'should create an Assignment instance with the given parameters' do
			@due_date = "2012-05-01 23:37:33 -0700".to_time
			@hard_deadline = "2012-05-01 23:37:33 -0700".to_time
      Assignment.should_receive(:create).with(:name => "name", :due_date => @due_date, :hard_deadline => @hard_deadline, :grading_strategy => "max", :autograder => nil, :submissions_limit => "3").and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys)
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :student_keys => "[s_key1, s_key2]", :inst_key => "inst_key", :format => :json}
    end
		it 'should add a list of student keys to the newly created assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :student_keys => "[s_key1, s_key2]", :inst_key => "inst_key", :format => :json}
		end
		it 'should save the assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :student_keys => "[s_key1, s_key2]", :inst_key => "inst_key", :format => :json}
		end
		it 'add the assignment to the instructor and save it' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      @fake_instructor.should_receive(:assignments).and_return(@assignments)
      @assignments.should_receive(:<<)
      @fake_instructor.should_receive(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :student_keys => "[s_key1, s_key2]", :inst_key => "inst_key", :format => :json}
		end
		it 'should render the create template' do
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :student_keys => "[s_key1, s_key2]", :inst_key => "inst_key", :format => :json}
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
      @assignments = [mock(:assignment), mock(:assignment)]
      @fake_instructor = mock(:instructor)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
    end
    it 'should get the file path from the params' do
			@autograder.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3",  :autograder => @autograder, :inst_key => "inst_key", :format => :json}
		end
		it 'should read the file content' do
			@autograder.stub_chain(:tempfile, :path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should create an Assignment instance with the given parameters' do
      @due_date = "2012-05-01 23:37:33 -0700".to_time
			@hard_deadline = "2012-05-01 23:37:33 -0700".to_time
      @autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
			Assignment.should_receive(:create).with(:name => "name", :due_date => @due_date, :hard_deadline => @hard_deadline, :grading_strategy => "max", :autograder => @content, :submissions_limit => "3").and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3",  :inst_key => "inst_key", :autograder => @autograder, :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:create).and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.should_receive(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3",  :inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should add the assignment to the instructors assignments and save' do
			Assignment.stub(:create).and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.should_receive(:save)
      @fake_instructor.should_receive(:assignments).and_return(@assignments)
      @assignments.should_receive(:<<)
      @fake_instructor.should_receive(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3",  :inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should render the create template' do
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			Assignment.stub(:create).and_return(@fake_assignment)
      @fake_assignment.stub(:save)
      @fake_instructor.stub_chain(:assignments, :<<)
      @fake_instructor.stub(:save)
      post :create, {:name => "name", :due_date => "2012-05-01 23:37:33 -0700", :hard_deadline => "2012-05-01 23:37:33 -0700", :grading_strategy => "max", :submissions_limit => "3", :inst_key => "inst_key", :autograder => @autograder, :format => :json}
			response.should render_template('create')
		end
  end

  #################### set_name ###############
  describe "set name" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
		it "should change name for given assignment" do
			@fake_assignment.should_receive(:name=).with("name")
			@fake_assignment.stub(:save)
      put :set_name, {:id => "id", :name => "name", :inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
			@fake_assignment.stub(:name=)
			@fake_assignment.should_receive(:save)
      put :set_name, {:id => "id", :name => "name", :inst_key => "inst_key", :format => :json}
			response.should render_template('set_name')
		end
  end

	#################### get_autograder ###############
  describe "Get the autograder for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :get_autograder, {:id => "id",:inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      put :get_autograder, {:id => "id",:inst_key => "inst_key", :format => :json}
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
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
    end
    it 'should get the file path from the params' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should read the file content' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
      @fake_assignment.stub(:autograder=).with(@content)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should add an autograder to the assignment' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_assignment.should_receive(:autograder=).with(@content)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.should_receive(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
		end
		it 'should render the create template' do
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@autograder.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_assignment.stub(:autograder=)
      @fake_assignment.stub(:save)
      put :set_autograder, {:id => "id",:inst_key => "inst_key", :autograder => @autograder, :format => :json}
			response.should render_template('set_autograder')
		end
  end
	describe "Set the Autograder with no autograder param" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
			put :set_autograder, {:id => "id",:inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'autograder\' missing.')
		end
	end
	
	#################### get_due_date ###############
  describe "Get the due_date for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find assignment by ID' do
      put :get_due_date, {:id => "id",:inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
      put :get_due_date, {:id => "id",:inst_key => "inst_key", :format => :json}
			response.should render_template('get_due_date')
		end
  end
	
	################ set_due_date ###########
  describe "Set due date for assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
		it 'should change the due date' do 
			@due_date = "2012-05-01 23:37:33 -0700".to_time
      @fake_assignment.should_receive(:due_date=).with(@due_date)
      @fake_assignment.stub(:save)
      put :set_due_date, {:id => "id", :inst_key => "inst_key", :due_date => "2012-05-01 23:37:33 -0700", :format => :json}
    end
		it 'should save the assignment' do
      @fake_assignment.stub(:due_date=)
      @fake_assignment.should_receive(:save)
      put :set_due_date, {:id => "id", :inst_key => "inst_key", :due_date => "2012-05-01 23:37:33 -0700", :format => :json}
		end
		it 'should render the correct template' do
      @fake_assignment.stub(:due_date=)
      @fake_assignment.stub(:save)
			put :set_due_date, {:id => "id", :inst_key => "inst_key", :due_date => "2012-05-01 23:37:33 -0700", :format => :json}
			response.should render_template('set_due_date')
		end
  end
	describe "Set the due date with no due date param" do
		it "should render an error" do 
		  @fake_instructor = mock(:instructor)
		  @fake_assignment = mock(:assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
			Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:instructor).and_return(@fake_instructor)
			put :set_due_date, {:id => "id", :inst_key => "inst_key", :due_date => "",  :format => :json}
			response.should render_template(:text => 'ERROR: invalid or missing param \'due_date\'.')
		end
	end 

	#################### get_hard_deadline ###############
  describe "Get the hard_deadline for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find assignment by ID' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      put :get_hard_deadline, {:id => "id", :inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      put :get_hard_deadline, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template('get_hard_deadline')
		end
  end
	
	################ set_hard_deadline ###########
  describe "Set late due date for assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find an assignment and change due date' do
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.stub(:save)
      put :set_hard_deadline, {:id => "id", :inst_key => "inst_key", :hard_deadline => "2012-05-01 23:37:33 -0700", :format => :json}
    end
		it 'should change the due date' do 
			@hard_deadline = "2012-05-01 23:37:33 -0700".to_time
      @fake_assignment.should_receive(:hard_deadline=).with(@hard_deadline)
      @fake_assignment.stub(:save)
      put :set_hard_deadline, {:id => "id", :inst_key => "inst_key", :hard_deadline => "2012-05-01 23:37:33 -0700", :format => :json}
    end
		it 'should save the assignment' do
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.should_receive(:save)
      put :set_hard_deadline, {:id => "id", :inst_key => "inst_key", :hard_deadline => "2012-05-01 23:37:33 -0700", :format => :json}
		end
		it 'should render the correct template' do
      @fake_assignment.stub(:hard_deadline=)
      @fake_assignment.stub(:save)
			put :set_hard_deadline, {:id => "id", :inst_key => "inst_key", :hard_deadline => "2012-05-01 23:37:33 -0700", :format => :json}
			response.should render_template('set_hard_deadline')
		end
  end
	describe "Set the late due date with no late due date param" do
		it "should render an error" do 
		 @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
			put :set_hard_deadline, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'required param \'hard_deadline\' missing.')
		end
	end  
	
	#################### set_grading_strategy ###############
  describe "set grading strategy" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
		it "should update the grading strategy for an assignement" do
		  @fake_assignment.stub_chain(:grading_strategies, :include?).and_return(true)
			@fake_assignment.should_receive(:grading_strategy=).with("max")
			@fake_assignment.stub(:save)
      put :set_grading_strategy, {:id => "id", :grading_strategy => "max", :inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
		  @fake_assignment.stub_chain(:grading_strategies, :include?).and_return(true)
			@fake_assignment.stub(:grading_strategy=)
			@fake_assignment.should_receive(:save)
      put :set_grading_strategy, {:id => "id", :grading_strategy => "max", :inst_key => "inst_key", :format => :json}
			response.should render_template('set_grading_strategy')
		end
		it 'Should render an error if strategy is not valid' do
		  @fake_assignment.stub_chain(:grading_strategies, :include?).and_return(false)
      put :set_grading_strategy, {:id => "id", :grading_strategy => "blah", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: invalid grading strategy passed in.')
		end
		
  end
  
  #################### set_submissions_limit ###############
  describe "set name" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
		it "should change name for given assignment" do
			@fake_assignment.should_receive(:submissions_limit=).with("3")
			@fake_assignment.stub(:save)
      put :set_submissions_limit, {:id => "id", :submissions_limit => "3", :inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
			@fake_assignment.stub(:submissions_limit=)
			@fake_assignment.should_receive(:save)
      put :set_submissions_limit, {:id => "id", :submissions_limit => "3", :inst_key => "inst_key", :format => :json}
			response.should render_template('set_submissions_limit')
		end
  end

	#################### list_student_keys ###############
  describe "list student keys for a givin assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
		it "should retrieve students from assignment" do
			@fake_assignment.should_receive(:students)
      put :list_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
		end
		it 'Should render the correct template' do
			@fake_assignment.stub(:students)
      put :list_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template('list_student_keys')
		end
  end

  #################### add_student_keys ###############
  describe "Addition of student keys per assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find an assignment by id' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :add_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
    end 
    it 'should add a student-keys' do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :add_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :add_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should render the add student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:add_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :add_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
			response.should render_template('add_student_keys')
		end
  end
	describe "Add student keys with no keys param" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
			put :add_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'keys\' missing.')
		end
	end  
	
 
	################ remove_student_keys ################ 
  describe "Deletion of student keys per assignment" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it 'should find an assignment by id' do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
    end 
    it 'should delete a student-keys' do 
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
      put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
    end
		it 'should save the assignment' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.should_receive(:save)
      put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
		end
		it 'should render the remove student keys template' do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:remove_student_keys).with(["s_key1", "s_key2"])
      @fake_assignment.stub(:save)
			put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :keys => "[s_key1, s_key2]", :format => :json}
			response.should render_template('remove_student_keys')
		end  
  end
	describe "Remove student keys with no keys param" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
			put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
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
      @num = mock(:integer)
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:submissions_limit).and_return(@num)
      @num.stub(">")

		end		
		it "should retreive students from assignment" do
			@fake_assignment.should_receive(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).with("key").and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should find student by key" do 
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.should_receive(:find_by_key).with("key").and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should get the file path from the params" do 
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
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read).and_return(@content)
			@student.should_receive(:add_submission).with(@content)
			@student.stub(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should save the changes on student" do 
			@fake_assignment.stub(:students).and_return(@student_list)
			@student_list.stub(:find_by_key).and_return(@student)
			@submission.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
			@student.stub(:add_submission)
			@student.should_receive(:save)
			put :submit, {:id => "id", :key => "key", :submission => @submission, :format => :json}
		end
		it "should render submit template" do
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
	describe "Invalid Submittion: " do
	  before(:each) do
	    @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
      @student = mock(:student)
      @submission = fixture_file_upload('/files/temp.rb')
      @student = mock(:student)
			@student_list = [mock(:student), mock(:student)]
	  end
		it "missing submission paramater and no student found should render an error" do 
      @fake_assignment.stub_chain(:students, :find_by_key)
			put :submit, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: student key doesn\'t exist and required param \'submission\' missing.')
		end
		it "missing submission paramater should render an error" do 
      @fake_assignment.stub_chain(:students, :find_by_key).and_return(@student)
			put :submit, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: required param \'submission\' missing.')
		end
		it "no student found should render an error" do 
      @fake_assignment.stub_chain(:students, :find_by_key)
			put :submit, {:id => "id", :inst_key => "inst_key", :submission => @submission, :format => :json}
			response.should render_template(:text => 'ERROR: student key doesn\'t exist.')
		end
	end
	

	############# retrieve_submissions ############
  describe "Retreive list of submissions by grading status" do
		before(:each) do
			@fake_assignment = mock(:assignment)
			@submissions_list = [mock(:submission), mock(:submission)]
			@filtered_submissions = [mock(:submission), mock(:submission)]
			@fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
		end		
		it "should find the assigment by id" do
			Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :status => "status", :format => :json}
		end
		it "should retreive submissions from assignment" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.should_receive(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :status => "status", :format => :json}
		end
		it "should filter submissions by status" do 
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.should_receive(:find_all_by_status).with("status").and_return(@filtered_submission)
			get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :status => "status", :format => :json}
		end
		it "should render retrieve_submission_by_status template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :status => "status", :format => :json}
			response.should render_template('retrieve_submissions')
		end
		it "should make the results available to the template" do
			Assignment.stub(:find_by_id).and_return(@fake_assignment)
			@fake_assignment.stub(:submissions).and_return(@submissions_list)
			@submissions_list.stub(:find_all_by_status).and_return(@filtered_submissions)
			get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :status => "status", :format => :json}
			assigns(:submissions).should == @filtered_submissions
		end
	end
	describe "Retreive list of submissions by student key" do
    before(:each) do
      @fake_assignment = mock(:assignment)
      @submissions_list = [mock(:submission), mock(:submission)]
      @filtered_submissions = [mock(:submission), mock(:submission)]
      @student = mock(:student)
      @student_list = [mock(:student), mock(:student)]
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
      @fake_assignment.stub(:instructor).and_return(@fake_instructor)
    end
    it "should find the assigment by id" do
      Assignment.should_receive(:find_by_id).with("id").and_return(@fake_assignment)
      @fake_assignment.stub(:submissions).and_return(@sumbission_list)
      Student.stub(:find_all_by_key).and_return(@student_list)
      @student_list.stub_chain(:map, :flat_map)
      get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :keys => "key", :format => :json}
    end
    it "should retreive students from assignment" do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.should_receive(:submissions).and_return(@sumbission_list)
      Student.stub(:find_all_by_key).and_return(@student_list)
      @student_list.stub_chain(:map, :flat_map)
      get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :keys => "key", :format => :json}
    end
    it "should find student by key" do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:submissions).and_return(@sumbission_list)
      Student.should_receive(:find_all_by_key).and_return(@student_list)
      @student_list.stub_chain(:map, :flat_map)
      get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :keys => "key", :format => :json}
    end
    it "should get submissions from student" do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:submissions).and_return(@sumbission_list)
      Student.should_receive(:find_all_by_key).and_return(@student_list)
      @student_list.stub_chain(:map, :flat_map)
      get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :keys => "key", :format => :json}
    end
    it "should render retrieve_submission_by_status template" do
      Assignment.stub(:find_by_id).and_return(@fake_assignment)
      @fake_assignment.stub(:submissions).and_return(@sumbission_list)
      Student.stub(:find_all_by_key).and_return(@student_list)
      @student_list.stub_chain(:map, :flat_map)
      get :retrieve_submissions, {:id => "id", :inst_key => "inst_key", :keys => "key", :format => :json}
      response.should render_template('retrieve_submission')
    end
  end
  
  describe "Invalid instructor key" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key")
			put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: professor key is not valid for this assignment')
		end
	end
	describe "Invalid instructor key" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      Assignment.stub(:find_by_id).with("id").and_return(@fake_assignment)
      Instructor.stub(:find_by_key).with("inst_key")
			post :create, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: professor key is not valid')
		end
	end
	describe "No Assignment" do
		it "should render an error" do 
		  @fake_assignment = mock(:assignment)
      @fake_instructor = mock(:instructor)
      Assignment.stub(:find_by_id).with("id")
      Instructor.stub(:find_by_key).with("inst_key").and_return(@fake_instructor)
			put :remove_student_keys, {:id => "id", :inst_key => "inst_key", :format => :json}
			response.should render_template(:text => 'ERROR: assignment does not exist' )
		end
	end
  
end

