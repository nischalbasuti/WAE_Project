Given("I am a user admin") do
  @admin = FactoryBot.create :admin

end

Given("I am signed in") do
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: @admin.email
  fill_in 'Password', with: @admin.password
  click_button 'Log in'
end

Given("I want to view the statistic of users") do
  @member = FactoryBot.create :member
  @coordination = FactoryBot.create :coordination
  @ban = FactoryBot.create :ban
end

When("I visit the statistic user page") do
  visit '/user_management/statistic_users'
end

Then("I should see the number of admin user") do
  expect(page).to have_content "The admin users "+User.where("users.global_role = 'admin'").count.to_s
end

Then("I should see the number of member user") do
  expect(page).to have_content "The member users "+User.where("users.global_role = 'member'").count.to_s
end

Then("I should see the number of coordination user") do
  expect(page).to have_content "The coordinator users "+User.where("users.global_role = 'coordinator'").count.to_s
end

Then("I should see the number of ban user") do
  expect(page).to have_content "The ban users "+User.where("users.global_role = 'ban'").count.to_s
end
