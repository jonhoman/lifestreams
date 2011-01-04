Feature: User registers an account
  In order to become a member of the website
  A visitor
  Wants to sign up for an account

  Scenario: User attempts to view the sign up page
    Given I am on the new user registration page
    Then I should see "Sign up"

  Scenario: User attempts to sign up
    Given I am on the new user registration page
    And I fill in "Email" with "jon@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    When I press "Sign up"
    Then I should have a valid user account

  Scenario: User attempts to sign up with an invalid email address
    Given I am on the new user registration page
    And I fill in "Email" with "jon@"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    When I press "Sign up"
    Then I should see "Email is invalid"
    And I should not have a valid user account with "jon@"

  Scenario: User attempts to sign up with an invalid email address
    Given I am on the new user registration page
    And I fill in "Email" with "jon@example.com"
    And I fill in "Password" with "pas"
    And I fill in "Password confirmation" with "pas"
    When I press "Sign up"
    Then I should see "Password is too short"
    And I should not have a valid user account with "jon@example.com"

  Scenario: User attempts to sign up with mismatched passwords
    Given I am on the new user registration page
    And I fill in "Email" with "jon@example.com"
    And I fill in "Password" with "password1"
    And I fill in "Password confirmation" with "password2"
    When I press "Sign up"
    Then I should see "Password doesn't match confirmation"
    And I should not have a valid user account with "jon@example.com"

