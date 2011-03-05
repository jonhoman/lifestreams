Feature: Show email list information
  In order to see the status of an email list
  As a user
  I want to view my email list's details

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I have an email list that has multiple recipients
    And I am on the dashboard
    
  Scenario: View show email list page
    When I follow "Jon's Email List"
    Then I should see recipients
