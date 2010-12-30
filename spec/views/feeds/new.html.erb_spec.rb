require 'spec_helper'

describe "feeds/new.html.erb" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path, :method => "post" do
      assert_select "input#feed_url", :name => "feed[url]"
    end
  end
end
