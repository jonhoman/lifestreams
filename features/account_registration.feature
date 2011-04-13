Feature: User registers an account
  In order to become a member of the website
  A visitor
  Wants to sign up for an account

  Scenario: User attempts to view the sign up page
    Given I am on the new user registration page
    Then I should see "Sign up"

  Scenario: User attempts to sign up
    Given I am on the new user registration page
    When I input my user information
    Then I should have a valid user account

  Scenario: User attempts to sign up with an invalid email address
    Given I am on the new user registration page
    When I input my user information with an invalid email address
    Then I should see that I submitted an invalid email
    And I should not have a valid user account with "jon@"

  Scenario: User attempts to sign up with a password that is too short
    Given I am on the new user registration page
    When I input my user information with an invalid password
    Then I should see that I submitted an invalid password
    And I should not have a valid user account with "jon@example.com"

  Scenario: User attempts to sign up with mismatched passwords
    Given I am on the new user registration page
    When I input my user information with a mismatched password
    Then I should see that I submitted a mismatched password
    And I should not have a valid user account with "jon@example.com"

