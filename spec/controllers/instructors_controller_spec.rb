require 'spec_helper'

describe InstructorsController do

  describe "GET 'index'" do
		it "should render error if no keys were given" do
      get 'status', :format => :json
      response.should render_template(:text => 'required param \'keys\' missing.')
    end
    it "returns http success" do
      get 'index', :format => :json
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
