Feature:User Registration

Scenario: User registration

Given I am a guest
When I visit the home page
Then I should see a link to sign up
When I click the link to sign up
Then I should see a form to sign up
When I submit the sign up form
Then I should see my new email on the home page
