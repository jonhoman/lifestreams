Given /^I have an email list I want to edit$/ do
  @email_list = Factory(:email_list, :name => "Jon's Email List", :user_id => @user.id)
end
