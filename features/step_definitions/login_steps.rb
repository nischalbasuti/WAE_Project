Given("I am not logged in") do
  @member = FactoryBot.create :member
end

When("I visit the home page") do
  visit '/'
end

Then("I should see a link to sign in") do
  find_link('Sign in',href: "/users/sign_in")
end

When("I click the link to sign in") do
  find_link('Sign in',href: "/users/sign_in").click
end

Then("I should see a form to sign in") do
  expect(page).to have_selector('form#new_user')
end

When("I submit the sign in form") do
  fill_in 'Email', with: @member.email
  fill_in 'Password', with: @member.password
  click_button 'Log in'
end

Then("I should see my email on the home page") do
  expect(page).to have_css('.navbar-text', text: @member.email)
end
