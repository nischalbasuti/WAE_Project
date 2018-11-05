
Given("I am a member") do
  # @user = User.new( :email => "user@ait.asia" :password => "password" :password_confirmation => "password" :global_role => "member").save!
  @user = FactoryBot.create :member
  visit '/users/sign_in'
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
  click_button "Log in"
end

Given("There is a forum") do
  @event = Event.new
  @event.id = 1
  @event.name = "event0"
  @event.description = "description0"
  @event.start_time = ""
  @event.end_time = ""
  @event.save

  @user.user_events.new(event: @event)
  @user.save

  @forum = Forum.new
  @forum.id = 1
  @forum.title = "forum0"
  # @forum.event_id = 1
  # @forum.save

  @event.forums << @forum
  @event.save
end

When("I visit the forums event") do
  visit '/events/1'
end

Then("I should see a link to the forum") do
  find_link(@forum.title, href: "/forums/#{@forum.id}")
end

When("I click the link to the forum") do
  find_link(@forum.title, href: "/forums/#{@forum.id}").click
end

Then("I should see a link for new comment") do
  find_link("New Comment", :visible => false)["href"]

end

When("I click the link for new comment") do
  find_link("New Comment", :visible => false).click
  visit find_link("New Comment", :visible => false)["href"]
end

Then("I should see a form for new comment") do
	# expect(page).to have_selector('form#new_comment')
  puts(current_url)
	find("textarea#comment_body")
end

When("I submit the form for new comment") do
  click_button 'Post Comment'
end

Then("I should see the new comment") do
  expect(page).to have_css('#comment_body', text: "")
end

