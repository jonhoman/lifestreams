Given /^I have an email list$/ do
  @email_list = Factory(:email_list, :name => "example email list", :user_id => @user.id)
end

Given /^I have an email list that has multiple recipients$/ do
  @email_list = Factory(:email_list, 
                        :name => "example email list", 
                        :user_id => @user.id, 
                        :recipients_text => "jon@jonhoman.com\njonphoman@gmail.com")
end

Given /^I am a recipient$/ do
  @recipient = @email_list.recipients.first
end

When /^I fill in "([^"]*)" with multiple recipients$/ do |field, recipients|
  When "I fill in \"#{field}\" with \"#{recipients}\""
end

When /^I unsubscribe from the email list$/ do
  When "I go to the unsubscribe page"
end

Then /^I should no longer be on the email list$/ do
  email_list = EmailList.last
  email_list.recipients.should_not include @recipient
end

Then /^the email list should have a recipient$/ do
  email_list = EmailList.last
  email_list.should have(1).recipients
end

Then /^the email list should have two recipients$/ do
  email_list = EmailList.last
  email_list.should have(2).recipients
end
