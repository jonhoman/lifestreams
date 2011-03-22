Feature: Delete a twitter account
  In order to stop using a twitter account
  A user
  Wants to be able to delete a twitter account
  
  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: Delete an existing twitter account
    Given I have a twitter account 
    And I go to the dashboard
    When I follow "Delete Twitter Account"
    Then I should not see "test"

  Scenario: Deleting an existing twitter account deactivates its associated stream
    Given I have a twitter account 
    And I add a stream
    And I add my twitter account to my stream
    And I go to the dashboard
    When I follow "Delete Twitter Account"
    Then the stream should not be active
