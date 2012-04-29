require 'spec_helper'

describe "professors/index" do
  before(:each) do
    assign(:professors, [
      stub_model(Professor,
        :prof_key => "Prof Key"
      ),
      stub_model(Professor,
        :prof_key => "Prof Key"
      )
    ])
  end

  it "renders a list of professors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Prof Key".to_s, :count => 2
  end
end
