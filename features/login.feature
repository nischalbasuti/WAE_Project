Feature:User Login

Scenario: User login 

Given I am not logged in
When I visit the home page
Then I should see a link to sign in
When I click the link to sign in
Then I should see a form to sign in
When I submit the sign in form
Then I should see my email on the home page
