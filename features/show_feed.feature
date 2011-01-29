Feature: Show feed information
  In order to see the status of a feed
  As a user
  I want to view my feed's details

  Scenario: View feed show page
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed that has items
    And I am on the user root page
    When I follow "example feed"
    Then I should see "example feed"
    And I should see "http://tanyahoman.com/feed"
    And I should see items
