Given /^I want to add a new email list$/ do
  click_link "Add new Email List"
end

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

Given /^I choose to import recipients$/ do
  click_link "Import email recipients from a text file"
end

When /^I enter the email list name$/ do
  fill_in "Email List Name", :with => "Test List"
  click_button "Create Email list"
end

When /^I enter the email list name and recipient$/ do
  fill_in "Email List Name", :with => "Test List"
  fill_in "Email Recipient", :with => "jon@jonhoman.com"
  click_button "Create Email list"
end

When /^I enter the email list name and multiple recipients$/ do
  fill_in "Email List Name", :with => "Test List"
  fill_in "Email Recipient", :with => "jon@jonhoman.com\njonphoman@gmail.com"
  click_button "Create Email list"
end

When /^I fill in "([^"]*)" with multiple recipients$/ do |field, recipients|
  When "I fill in \"#{field}\" with \"#{recipients}\""
end

When /^I change the email list name$/ do
  visit(edit_email_list_path(EmailList.last))
  fill_in "Email List Name", :with => "Jon's Real Email List"
  click_button "Update Email list"
end

When /^I change the email list name to be blank$/ do
  visit(edit_email_list_path(EmailList.last))
  fill_in "Email List Name", :with => ""
  click_button "Update Email list"
end

When /^I view the edit page for an email list$/ do
  visit(edit_email_list_path(EmailList.last))
end

When /^I unsubscribe from the email list$/ do
  When "I go to the unsubscribe page"
end

When /^I upload a text file with recipients$/ do
  attach_file(:text_file, File.join(Rails.root.to_s, 'features', 'uploaded-files', 'recipients.txt'))
  click_button "Import"
end

When /^I delete my email list$/ do
  click_link "Delete Email List"
end

Then /^I should no longer be on the email list$/ do
  page.should have_content "You have been unsubscribed from the email list."
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

Then /^the email list name should be updated$/ do
  email_list = EmailList.last
  email_list.name.should eq "Jon's Real Email List"
end

Then /^the recipients should be editable$/ do
  page.should have_content "jon@jonhoman.com"
  page.should have_content "jonphoman@gmail.com"
end

Then /^my email list is removed$/ do
  page.should_not have_content "Jon's Email List"
  EmailList.count.should be_zero
end
