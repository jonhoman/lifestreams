Given /^I have a feed I want to edit$/ do
  VCR.use_cassette("feed") do
    @feed = Factory(:feed, :name => "Jon's Feed", :url => "http://example.org/feed", :user_id => @user.id)
  end
end

When /^change the feed name to "([^"]*)"$/ do |name|
  fill_in("Feed Name", :with => name)
end

When /^I submit the form to ([^"]*) the feed$/ do |action|
  VCR.use_cassette("feed") do
    click_button "#{action.titleize} Feed"
  end
end

When /^I view "([^"]*)"$/ do |name|
  VCR.use_cassette("bitly") do
    When 'I follow "example feed"'
  end
end

When /^I enter my feed information$/ do
  fill_in "Feed Name", :with => "Test Feed"
  fill_in "URL", :with => "http://tanyahoman.com/feed/"
end

When /^I enter blog url$/ do
  fill_in "URL", :with => "http://tanyahoman.com/"
end

When /^I change my feed's name$/ do
  visit(edit_feed_path(Feed.last))
  fill_in "Feed Name", :with => "Jon's Real Feed"
end

When /^I delete my feed$/ do
  click_link "Delete Feed"
end

Then /^my feed's name should be changed$/ do
  page.should have_content "Jon's Real Feed"
end

Then /^my feed is removed$/ do
  page.should_not have_content "Jon's Feed"
  Feed.count.should be_zero
end
