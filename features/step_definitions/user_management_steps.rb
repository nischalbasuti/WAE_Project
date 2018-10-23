Given("I am an admin user") do
  @admin = FactoryBot.create :admin
end

Given("there is a user") do
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
  @ban = FactoryBot.create :ban
end

When("I visit the user management page") do
  visit '/user_management/show'
end

Then("I should see the detail of user") do
  expect(page).to have_content "#{@member.email }"
end

Then("I should see date of user registration") do
  expect(page).to have_content "#{@member.created_at.to_date }"
end

Then("I should see a ban user button") do
  expect(page).to have_link('ban user',href: "/user_management/ban?id=2")
end

When("I click the button to ban a user") do
  find_link('ban user',href: "/user_management/ban?id=2").click
end

Then("I should see The user has been banned") do
  expect(page).to have_content "The user has been banned!"
end

Then("I should see an unban user button") do
  expect(page).to have_link('ban user',href: "/user_management/unban?id=2")
end
