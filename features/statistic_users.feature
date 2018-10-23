Feature:Statistic users

Scenario: view the statistic of users

  A user admin should be able to view the statistic of users.

Given I am a user admin
And there is a statistic user
And I am logged in
And I want to view the statistic of users
When I visit the statistic user page
Then I should see the number of admin user
And I should see the number of member user
And I should see the number of coordination user
And I should see the number of ban user
