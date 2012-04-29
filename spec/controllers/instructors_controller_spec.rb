require 'spec_helper'

describe InstructorsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', :format => :json
      response.should be_success
    end
  end

  describe "GET 'authorize'" do
    it "returns http success" do
      get 'authorize', :format => :json
      response.should be_success
    end
  end

  describe "GET 'deauthorize'" do
    it "returns http success" do
      get 'deauthorize', :format => :json
      response.should be_success
    end
  end

end
