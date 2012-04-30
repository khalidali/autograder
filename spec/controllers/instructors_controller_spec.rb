require 'spec_helper'

describe InstructorsController do

  describe "GET 'index'" do
		before(:each) do
			@instructors = {"khalid" => "authorized", "robert" => "unauthorized"}
		end
		it "should render error if no keys were given" do
      get 'status', :format => :json
      response.should render_template(:text => 'required param \'keys\' missing.')
    end
    it "returns http success" do
			Instructor.stub(:find_by_key).with('khalid').and_return(true)
			Instructor.stub(:fing_by_key).with('robert').and_return(false)
      get 'index', :keys => "['khalid','robert']", :format => :json
			assigns(:instructors).should_equal @instructors
      response.should be_success
    end
  end

	describe "GET 'status'" do
    it "should render error if no keys were given" do
      get 'status', :format => :json
      response.should render_template(:text => 'required param \'keys\' missing.')
    end
  end

  describe "GET 'authorize'" do
		it "should render error if no keys were given" do
      get 'status', :format => :json
      response.should render_template(:text => 'required param \'keys\' missing.')
    end
    it "returns http success" do
      get 'authorize', :format => :json
      response.should be_success
    end
  end

  describe "GET 'deauthorize'" do
		it "should render error if no keys were given" do
      get 'status', :format => :json
      response.should render_template(:text => 'required param \'keys\' missing.')
    end
    it "returns http success" do
      get 'deauthorize', :format => :json
      response.should be_success
    end
  end

end
