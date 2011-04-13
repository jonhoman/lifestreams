Feature: Dashboard interface
  In order to view all stream-related information in one place
  A user
  Wants a dashboard
  
  Background:
    Given I am a user
    And I sign in

  Scenario: Non-authenticated tries to view a dashboard
    Given I follow "Sign out"
    When I go to the dashboard
    Then I should be on the new user session page

  Scenario: User should be able to add a new twitter account
    Then I should see "Add new Twitter Account"

  Scenario: User should be able to add a feed 
    Then I should see "Add new feed"

  Scenario: User should be able to add a stream
    Then I should see "Add new Stream"

  Scenario: User should be able to add an email list
    Then I should see "Add new Email List"

  Scenario: User should be able to add a new facebook account
    Then I should see "Add new Facebook Account"

  Scenario: User goes to their dashboard
    When I go to the dashboard
    Then I should be on the dashboard

  Scenario: User should see their configured twitter accounts
    Given I configure my twitter account
    When I go to the dashboard
    Then I should see my configured twitter account

  Scenario: User should not see other users' configured twitter accounts
    Given I configure my twitter account
    And another user configures a twitter account
    When I go to the dashboard
    Then I should see my configured twitter account
    And I should not see the other user's twitter account

  Scenario: User should see their feeds 
    Given I add a feed 
    When I go to the dashboard
    Then I should see my feed 

  Scenario: User should see their streams 
    Given I add a stream 
    When I go to the dashboard
    Then I should see my stream

  Scenario: User should see their email lists 
    Given I add an email list 
    When I go to the dashboard
    Then I should see my email list

  Scenario: User should see their configured facebook account
    Given I configure my facebook account 
    When I go to the dashboard
    Then I should see my configured facebook account

  Scenario: User should not see other users' configured twitter accounts
    Given I configure my twitter account
    And another user configures a twitter account
    When I go to the dashboard
    Then I should see my configured twitter account
    And I should not see the other user's twitter account

  Scenario: Blog help text should be displayed
    When I go to the dashboard
    Then I should see "What blog (or other feed) you would like to share with other people?"

  Scenario: Twitter help text should be displayed
    When I go to the dashboard
    Then I should see "Connect your Twitter account."
    
  Scenario: Stream help text should be displayed
    When I go to the dashboard
    Then I should see "Share a feed by creating a stream."

  Scenario: Email help text should be displayed 
    When I go to the dashboard
    Then I should see "Use email to share your feeds to your friends without Twitter or Facebook."

  Scenario: Facebook help text should be displayed 
    When I go to the dashboard
    Then I should see "Share your blog updates with your friends on Facebook."
