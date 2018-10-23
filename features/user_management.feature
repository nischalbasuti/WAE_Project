Feature: User management

Scenario: Ban a user

  A user admin should be able to ban a user.

Given I am an admin user
And there is a user management
And I am logged in
And I want to ban a user
When I visit the user management page
Then I should see the detail of user
And I should see date of user registration
And I should see a ban user button
When I click the button to ban a user
Then I should see The user has been banned
And I should see an unban user button
