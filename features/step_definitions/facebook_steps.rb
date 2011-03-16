Then /^I should not see my facebook account$/ do
  FacebookAccount.count.should == 0
end

