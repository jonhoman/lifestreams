Feature: Create a new email list
  In order to send email to multiple recipients
  A user
  Wants to create mailing lists

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  @wip
  Scenario: New feed create 
    Given I am on the user root page
    And I follow "Add new Email List"
    When I fill in "Email List Name" with "Test List"
    And I press "New Email List"
    Then I should be on the user root page
    And I should have the following fields for the email list:
      |Name      |
      |Test List |



