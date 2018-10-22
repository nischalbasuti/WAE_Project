Given("I am a user admin") do
  @user = FactoryBot.create :admin
end

Given("I am logged in") do
  visit '/'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

Given("I want to ban a user") do
  @user = FactoryBot.create :user
end

When("I visit the user management page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see the details of user") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see a button to ban a user") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click the button to ban a user") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see the a banned successfully notice") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see a button to unban a user") do
  pending # Write code here that turns the phrase above into concrete actions
end
