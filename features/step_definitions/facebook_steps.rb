When /^I delete my facebook account$/ do 
  click_link "Delete Facebook Account"
end

Then /^my facebook account should be removed$/ do
  page.should_not have_content "my facebook account"
  FacebookAccount.count.should == 0
end

