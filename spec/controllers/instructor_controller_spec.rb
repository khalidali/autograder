require 'spec_helper'

describe InstructorController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'authorize'" do
    it "returns http success" do
      get 'authorize'
      response.should be_success
    end
  end

  describe "GET 'deauthorize'" do
    it "returns http success" do
      get 'deauthorize'
      response.should be_success
    end
  end

end
