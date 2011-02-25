Given /^I have an email list I want to edit$/ do
  @email_list = Factory(:email_list, :name => "Jon's Email List", :user_id => @user.id)
end

When /^I fill in "([^"]*)" with multiple recipients$/ do |field, recipients|
  When "I fill in \"#{field}\" with \"#{recipients}\""
end

