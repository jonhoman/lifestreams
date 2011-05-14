Given /^I have a feed I want to edit$/ do
  @feed = Factory(:feed, :name => "Jon's Feed", :url => "http://example.org/feed", :user_id => @user.id)
end

When /^I submit the form to ([^"]*) the feed$/ do |action|
  click_button "#{action.titleize} Feed"
end

When /^I view my feed$/ do
  visit(feed_path(Feed.last))
end

When /^I view my feed that has clicks$/ do
  visit(feed_path(Feed.last))
end

When /^I enter my feed information$/ do
  fill_in "Feed Name", :with => "Test Feed"
  fill_in "URL", :with => "http://tanyahoman.com/feed/"
end

When /^I change my feed's name$/ do
  visit(edit_feed_path(Feed.last))
  fill_in "Feed Name", :with => "Jon's Real Feed"
end

When /^I delete my feed$/ do
  click_link "Delete this feed"
end

Then /^my feed's name should be changed$/ do
  feed = Feed.last
  feed.name.should == "Jon's Real Feed"
end

Then /^my feed is removed$/ do
  page.should_not have_content "Jon's Feed"
  Feed.count.should be_zero
end

Then /^I should see the feed information$/ do
  page.should have_content "example feed"
  page.should have_content "http://tanyahoman.com"
  Then 'I should see items'
end

Then /^I should see the number of clicks$/ do
  page.should have_content "visited 0 times"
end
