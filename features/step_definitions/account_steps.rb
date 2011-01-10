Given /^I am a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  @user = Factory(:user, :email => email, :password => password, :password_confirmation => password)
end

Given /^I sign in$/ do
  And "I am on the new user session page"
  And 'I fill in "Email" with "jon@example.com"'
  And 'I fill in "Password" with "password"'
  And 'I press "Sign in"'
end

Given /^I am signed in$/ do
  Given 'I am a user with email "jon@example.com" and password "password"'
  And 'I sign in'
end

Then /^I should have a valid user account$/ do
  @user = User.find_by_email("jon@example.com")
  @user.should_not be_nil
end

Then /^I should not have a valid user account with "([^"]*)"$/ do |email_address|
  @user = User.find_by_email("email_address")
  @user.should be_nil
end

Then /^I should view the streams page$/ do
  page.should have_content('Streams')
end

