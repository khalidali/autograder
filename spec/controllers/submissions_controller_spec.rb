require 'spec_helper'


describe SubmissionsController do

  #################### update_status ###############
  describe "Update Grading Status" do
    before(:each) do
      @fake_submission = mock(:submission)
      @path = mock(:string)
      @content = mock(:string)
      @output = fixture_file_upload('/files/temp.rb')
      @file = mock(:file)
    end
    it 'should find an submission by id' do
      Submission.should_receive(:find_by_id).with("id").and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path)
      File.stub_chain(:open, :read)
      @fake_submission.stub(:output=)
      @fake_submission.stub(:status=)
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end
    it 'should get the file path from the params' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.should_receive(:tempfile).and_return(@file)
      @file.should_receive(:path).and_return(@path)
      File.stub_chain(:open, :read)
      @fake_submission.stub(:output=)
      @fake_submission.stub(:status=)
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end
    it 'should read the file content' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path).and_return(@path)
      File.should_receive(:open).and_return(@file)
      @file.should_receive(:read).and_return(@content)
      @fake_submission.stub(:output=).with(@content)
      @fake_submission.stub(:status=)
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end
    it 'should update the output' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path).and_return(@path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_submission.should_receive(:output=).with(@content)
      @fake_submission.stub(:status=)
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end
    it 'should update the status' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path).and_return(@path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_submission.stub(:output=)
      @fake_submission.should_receive(:status=).with("status")
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end 
    it 'should save the submission' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path).and_return(@path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_submission.stub(:output=)
      @fake_submission.stub(:status=)
      @fake_submission.should_receive(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
    end
    it 'should render the update_status template' do
      Submission.stub(:find_by_id).and_return(@fake_submission)
      @output.stub_chain(:tempfile, :path).and_return(@path)
      File.stub_chain(:open, :read).and_return(@content)
      @fake_submission.stub(:output=)
      @fake_submission.stub(:status=).with("status")
      @fake_submission.stub(:save)
      put :update_status, {:id => "id", :status => "status", :output => @output}
      response.should render_template("update_status")
    end   
  end
end
