Feature: Create a new stream
  In order to share my blog posts
  As a user
  I want to create a new stream

  Background:
    Given I am a user with email "jon@example.com" and password "password"
    And I sign in
    And I add a feed
    And I configure two twitter accounts

  Scenario: Stream created with a feed and a twitter account 
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I select "test" from "Choose a Twitter Account" 
    And I press "Create Stream"
    Then I should be on the user root page
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I choose
    And my stream should have a reference to the twitter account I choose

  Scenario: Stream created with a feed and 2 twitter accounts
    Given I follow "Add new Stream"
    When I fill in "Stream Name" with "Test Stream"
    And I select "example feed" from "Choose a Feed" 
    And I select "test" from "Choose a Twitter Account" 
    And I select "different_handle" from "Choose a Twitter Account" 
    And I press "Create Stream"
    Then I should be on the user root page
    And I should have the following fields stored for the stream:
      |Name       |
      |Test Stream|
    And my stream should have a reference to the feed I choose
    And my stream should have two twitter accounts

  Scenario: Stream created without a name 
    Given I follow "Add new Stream"
    And I select "test" from "Choose a Twitter Account" 
    When I press "Create Stream"
    Then I should see "Name can't be blank"

  Scenario: Editing a stream selects the correct twitter account 
    Given I have a stream I want to edit
    And I am on the user root page
    When I follow "example stream"
    And I follow "Edit"
    Then the twitter account should be selected

  Scenario: Edit a stream created with a feed and a twitter account 
    Given I have a stream I want to edit
    And I am on the user root page
    When I follow "example stream"
    And I follow "Edit"
    And I change the stream name to "Real Stream"
    And I press "Update Stream"
    Then I should see "Real Stream"

  Scenario: Delete an existing stream
    Given I have a stream I want to edit
    And I go to the user root page
    When I follow "Delete Stream"
    Then I should not see "Jon's Feed"
