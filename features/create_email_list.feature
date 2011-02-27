Feature: Create a new email list
  In order to send email to multiple recipients
  A user
  Wants to create mailing lists

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in

  Scenario: Create new email list 
    Given I follow "Add new Email List"
    When I fill in "Email List Name" with "Test List"
    And I press "Create Email list"
    Then I should be on the user root page
    And I should have the following fields stored for the email list:
      |Name      |
      |Test List |

  Scenario: Create new email list without a name
    Given I follow "Add new Email List"
    When I press "Create Email list"
    Then I should see "Name can't be blank"

  Scenario: Create new email list with email recipient
    Given I follow "Add new Email List"
    When I fill in "Email List Name" with "Test List"
    And I fill in "Email Recipient" with "jon@jonhoman.com"
    And I press "Create Email list"
    Then I should be on the user root page
    And I should have the following fields stored for the email list:
      |Name      | 
      |Test List |
    And the email list should have a recipient

  Scenario: Create new email list with multiple recipients (stored as comma-separated list)
    Given I follow "Add new Email List"
    When I fill in "Email List Name" with "Test List"
    And I fill in "Email Recipient" with multiple recipients
      """
      jon@jonhoman.com
      jonphoman@gmail.com
      """
    And I press "Create Email list"
    Then I should be on the user root page
    And I should have the following fields stored for the email list:
      |Name      |
      |Test List |
    And the email list should have two recipients

  Scenario: Edit an existing email list
    Given I have an email list I want to edit
    And I am on the user root page
    When I follow "Jon's Email List"
    And I follow "Edit"
    Then I should see "Jon's Email List"
    When I fill in "Email List Name" with "Jon's Real Email List"
    And I press "Update Email list"
    Then I should see "Jon's Real Email List"

  Scenario: Edit an existing email list that has multiple recipients
    Given I have an email list I want to edit that has multiple recipients
    And I am on the user root page
    When I follow "Jon's Email List"
    And I follow "Edit"
    Then I should see "jon@jonhoman.com"
    And I should see "jonphoman@gmail.com"
  
  Scenario: Edit email list and erase the name
    Given I have an email list I want to edit
    And I am on the user root page
    When I follow "Jon's Email List"
    And I follow "Edit"
    Then I should see "Jon's Email List"
    When I fill in "Email List Name" with ""
    And I press "Update Email list"
    Then I should see "Name can't be blank"
  
  Scenario: Delete existing email list
    Given I have an email list I want to edit
    And I go to the user root page
    When I follow "Delete Email List"
    Then I should not see "Jon's Email List"
