require 'spec_helper'

describe "professors/edit" do
  before(:each) do
    @professor = assign(:professor, stub_model(Professor,
      :prof_key => "MyString"
    ))
  end

  it "renders the edit professor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => professors_path(@professor), :method => "post" do
      assert_select "input#professor_prof_key", :name => "professor[prof_key]"
    end
  end
end
