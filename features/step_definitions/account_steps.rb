Given /^I am a user$/ do 
  @user = Factory(:user, :email => "jon@example.com", :password => "password", :password_confirmation => "password")
end

Given /^I sign in$/ do
  And "I am on the new user session page"
  And 'I fill in "Email" with "jon@example.com"'
  And 'I fill in "Password" with "password"'
  And 'I press "Sign in"'
end

When /^I input my user information$/ do
  fill_in "Email", :with => "jon@example.com"
  fill_in "Password", :with => "password"
  fill_in "Password confirmation", :with => "password"
  click_button "Sign up"
end

When /^I input my user information with an invalid email address$/ do
  fill_in "Email", :with => "jon@"
  fill_in "Password", :with => "password"
  fill_in "Password confirmation", :with => "password"
  click_button "Sign up"
end

When /^I input my user information with an invalid password$/ do
  fill_in "Email", :with => "jon@example.com"
  fill_in "Password", :with => "pas"
  fill_in "Password confirmation", :with => "pas"
  click_button "Sign up"
end

When /^I input my user information with a mismatched password$/ do
  fill_in "Email", :with => "jon@example.com"
  fill_in "Password", :with => "password1"
  fill_in "Password confirmation", :with => "password2"
  click_button "Sign up"
end

When /^I sign in with a bad email address$/ do
  fill_in "Email", :with => "jon@"
  fill_in "Password", :with => "password"
  click_button "Sign in"
end

When /^I sign in with a bad password$/ do
  fill_in "Email", :with => "jon@"
  fill_in "Password", :with => "pass"
  click_button "Sign in"
end

When /^I sign out$/ do
  click_link 'Sign out'
end

Then /^I should see that I submitted an invalid email$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see that I submitted an invalid password$/ do
  page.should have_content "Password is too short"
end

Then /^I should see that I submitted a mismatched password$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see that I submitted a bad email or password$/ do
  page.should have_content "Invalid email or password"
end

Then /^I should have a valid user account$/ do
  @user = User.find_by_email("jon@example.com")
  @user.should_not be_nil
end

Then /^I should not have a valid user account with "([^"]*)"$/ do |email_address|
  @user = User.find_by_email("email_address")
  @user.should be_nil
end

Then /^I should see that I have signed in$/ do
  page.should have_content "Signed in successfully"
end

Then /^I should be able to sign out$/ do
  page.should have_content "Sign out"
end

Then /^I should be able to sign up or sign in$/ do
  page.should have_content "Sign up or sign in"
end

Then /^I should see links to the dashboard and account settings$/ do
  page.should have_link "Dashboard"
  page.should have_link "Account Settings"
end
