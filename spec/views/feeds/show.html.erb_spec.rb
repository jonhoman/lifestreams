require 'spec_helper'

describe "feeds/show.html.erb" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
