Then("{string} should receive an email") do |email_address|
  @email = ActionMailer::Base.deliveries.last
  expect(@email).to be_present
  expect(@email.to).to include(email_address)
end

Then("the email contents should contain a link to the {string} gym page") do |gym_name|
  gym = Gym.find_by(name: gym_name)

  expect(@email.body).to include(gym_path(gym))
end
