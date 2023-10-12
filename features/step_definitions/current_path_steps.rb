# =======
# General
# =======
Then("I should be on the homepage") do
  expect(current_path).to eq "/"
end

Then("I should be redirected to the {string} page") do |path|
  path_helper = "#{path.downcase.tr(" ", "_")}_path"

  expect(current_path).to eq(send(path_helper))
end

Then("I should be redirected to the {string} page for") do |path, table|
  expect_path_for(path, table)
end

When("I should be on the {string} page for") do |path, table|
  expect_path_for(path, table)
end

def expect_path_for(path, table)
  objects = []

  table.headers.each_with_index do |header, index|
    class_attribute = table.headers[index].split(" ")
    class_name = class_attribute.first
    attribute = class_attribute.last
    klass = class_name.constantize
    value = table.rows.first[index]
    objects << klass.find_by({attribute => value})
  end

  path_helper = "#{path.downcase.tr(" ", "_")}_path"

  expect(current_path).to eq(send(path_helper, *objects))
end

# ====
# Auth
# ====
Then("I should be on the Signup page") do
  expect(current_path).to eq new_user_registration_path
end

Then("I should be on the login page") do
  expect(current_path).to eq new_user_session_path
end

# =====
# Admin
# =====
Then("I should be on the admin login page") do
  expect(current_path).to eq(new_admin_user_session_path)
end

Then("I am on the Admin page") do
  expect(current_path).to eq(admin_root_path)
end

# ======
# Videos
# ======
Then("I should be on the {string} video for {string}") do |video_title, gym_name|
  gym = Gym.find_by(name: gym_name)

  video = Video.find_by(title: video_title, gym: gym)

  expect(current_path).to eq(gym_video_path(video.gym_id, video))
end

# ====
# Gyms
# ====
Then("I should be on the Gyms page") do
  expect(current_path).to eq gyms_path
end

Then("I should be on the create gym page") do
  expect(current_path).to eq new_gym_path
end

Then("I should be on the {string} gym page.") do |gym_name|
  @gym = Gym.find_by(name: gym_name)

  expect(current_path).to eq gym_path(@gym)
end

Then("I should be on the members page for {string}") do |gym_name|
  @gym = Gym.find_by(name: gym_name)

  expect(current_path).to eq gym_memberships_path(@gym)
end
