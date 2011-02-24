When /^I should have the following fields stored for the stream:$/ do |table|
  stream = Stream.last
  table.hashes.each do |row|
    row.keys.each do |header|
      stream.send(header.dehumanize).to_s.should == row[header]
    end
  end
end

When /^I should have the following fields stored for the feed:$/ do |table|
  feed = Feed.last
  table.hashes.each do |row|
    row.keys.each do |header|
      feed.send(header.dehumanize).to_s.should == row[header]
    end
  end
end

When /^I should have the following fields stored for the email list:$/ do |table|
  email_list = EmailList.last
  table.hashes.each do |row|
    row.keys.each do |header|
      email_list.send(header.dehumanize).to_s.should == row[header]
    end
  end
end

Then /^my stream should have a reference to the feed I choose$/ do
  stream = Stream.last
  stream.feed_id.should_not be_nil
end

Then /^my stream should have a reference to the twitter account I choose$/ do
  stream = Stream.last
  stream.feed_id.should_not be_nil
end

Then /^my stream should have two twitter accounts$/ do
  stream = Stream.last
  stream.twitter_accounts.count.should == 2
end
