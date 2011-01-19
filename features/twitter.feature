Feature: Delete a twitter account
  In order to stop using a twitter account
  A user
  Wants to be able to delete a twitter account

  Scenario:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I have a twitter account 
    And I go to the user root page
    When I follow "Delete Twitter Account"
    Then I should not see "test"
