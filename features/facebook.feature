Feature: Delete a facebook account
  In order to stop using a facebook account
  A user 
  Wants to be able to delete a twitter account

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: Delete an existing facebook account
    Given I configure my facebook account
    And I go to the dashboard
    When I follow "Delete Facebook Account"
    Then I should not see my facebook account

  @wip
  Scenario: Deleting an existing facebook account deactivates its associated stream
    Given I configure my facebook account 
    And I add a stream
    And I add my facebook account to my stream
    And I go to the dashboard
    When I follow "Delete Facebook Account"
    Then the stream should not be active
