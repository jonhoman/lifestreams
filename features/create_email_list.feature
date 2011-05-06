Feature: Create a new email list
  In order to send email to multiple recipients
  A user
  Wants to create mailing lists

  Background:
    Given I am a user
    And I sign in

  Scenario: Create new email list 
    Given I want to add a new email list
    When I enter the email list name
    Then I should be on the dashboard
    And I should have the following fields stored for the email list:
      |Name      |
      |Test List |

  Scenario: Create new email list with email recipient
    Given I want to add a new email list
    When I enter the email list name and recipient
    Then I should have the following fields stored for the email list:
      |Name      | 
      |Test List |
    And the email list should have a recipient

  Scenario: Create new email list with multiple recipients (stored as comma-separated list)
    Given I want to add a new email list
    When I enter the email list name and multiple recipients
    Then I should have the following fields stored for the email list:
      |Name      |
      |Test List |
    And the email list should have two recipients

  Scenario: Create new email list from text file
    Given I want to add a new email list
    And I choose to import recipients
    When I upload a text file with recipients
    Then the email list should have two recipients

  Scenario: Edit an existing email list
    Given I have an email list 
    And I am on the dashboard
    When I change the email list name
    Then the email list name should be updated

  Scenario: Edit an existing email list that has multiple recipients
    Given I have an email list that has multiple recipients
    And I am on the dashboard
    When I view the edit page for an email list
    Then I should see "jon@jonhoman.com"
    And I should see "jonphoman@gmail.com"
  
  Scenario: Edit email list and erase the name
    Given I have an email list 
    And I am on the dashboard
    When I change the email list name to be blank
    Then I should see that the name cannot be blank
  
  Scenario: Delete existing email list
    Given I have an email list
    And I go to the email list page
    When I delete my email list
    Then my email list is removed

  Scenario: User unsubscribes from a email list
    Given I have an email list that has multiple recipients
    And I am a recipient
    When I unsubscribe from the email list
    Then I should no longer be on the email list
