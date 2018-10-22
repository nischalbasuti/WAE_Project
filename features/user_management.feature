Feature: User management

Scenario: Ban a user

  A user admin should be able to ban a user.

Given I am a user admin
And I am logged in
And I want to ban a user
When I visit the user management page
Then I should see the details of user
And I should see a button to ban a user
When I click the button to ban a user
Then I should see the a banned successfully notice
And I should see a button to unban a user
