Given("I am a guest") do
  @email = "test@testmail.com"
  @password = "123456"
end

Then("I should see a link to sign up") do
  find_link('Sign up',href: "/users/sign_up")
end

When("I click the link to sign up") do
  find_link('Sign up',href: "/users/sign_up").click
end

Then("I should see a form to sign up") do
  expect(page).to have_selector('form#new_user')
end

When("I submit the sign up form") do
  fill_in 'Email', with: @email
  fill_in 'Password', with: @password
  fill_in 'Password confirmation', with: @password
  click_button 'Sign up'
end

Then("I should see my new email on the home page") do
  expect(page).to have_css('.navbar-text', text: @email)
end
