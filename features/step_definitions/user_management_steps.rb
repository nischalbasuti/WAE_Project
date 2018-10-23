Given("I am an admin user") do
  @admin = FactoryBot.create :admin
end

Given("there is a user management") do
  @member = FactoryBot.create :member
end

Given("I am logged in") do
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: @admin.email
  fill_in 'Password', with: @admin.password
  click_button 'Log in'
end

Given("I want to ban a user") do
  @user = FactoryBot.create :member
end

When("I visit the user management page") do
  visit '/user_management/show'
end

Then("I should see the detail of user") do
  expect(page).to have_content "#{@user.email :member}"
end

Then("I should see date of user registration") do
  expect(page).to have_content "#{@user.created_at :member}"
end

Then("I should see a ban user button") do
  expect(page).to have_link_to "ban user", {:action => :ban, :id => user.id}, :class => "btn btn-danger"
end

When("I click the button to ban a user") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see The user has been banned") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see an unban user button") do
  pending # Write code here that turns the phrase above into concrete actions
end
