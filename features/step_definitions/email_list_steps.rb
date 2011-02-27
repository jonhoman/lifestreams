Given /^I have an email list I want to edit$/ do
  @email_list = Factory(:email_list, :name => "Jon's Email List", :user_id => @user.id)
end

Given /^I have an email list I want to edit that has multiple recipients$/ do
  @email_list = Factory(:email_list, 
                        :name => "Jon's Email List", 
                        :user_id => @user.id, 
                        :recipients_text => "jon@jonhoman.com\njonphoman@gmail.com")
end

When /^I fill in "([^"]*)" with multiple recipients$/ do |field, recipients|
  When "I fill in \"#{field}\" with \"#{recipients}\""
end

Then /^the email list should have a recipient$/ do
  email_list = EmailList.last
  email_list.should have(1).recipients
end

Then /^the email list should have two recipients$/ do
  email_list = EmailList.last
  email_list.should have(2).recipients
end
