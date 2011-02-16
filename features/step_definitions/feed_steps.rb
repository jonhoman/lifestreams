Given /^I have a feed I want to edit$/ do
  VCR.use_cassette("feed", :record => :new_episodes) do
    @feed = Feed.create!(:name => "Jon's Feed", :url => "http://example.org/feed", :user_id => @user.id)
  end
end

When /^change the feed name to "([^"]*)"$/ do |name|
  fill_in("Feed Name", :with => name)
end

When /^I submit the form to ([^"]*) the feed$/ do |action|
  VCR.use_cassette("feed", :record => :new_episodes) do
    When "I press \"#{action.titleize} Feed\""
  end
end

When /^I view "([^"]*)"$/ do |name|
  VCR.use_cassette("bitly", :record => :new_episodes) do
    When 'I follow "example feed"'
  end
end
