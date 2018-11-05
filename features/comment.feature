Feature: Comment on forums

Scenario: Comment on forums

Given I am a member
And There is a forum
When I visit the forums event
Then I should see a link to the forum 
When I click the link to the forum
Then I should see a link for new comment
When I click the link for new comment
# Then I should see a form for new comment
# When I submit the form for new comment
# Then I should see the new comment
