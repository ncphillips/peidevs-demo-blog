# =======
# Generic
# =======
When("I reload the page") do
  visit current_url
end

When("I open the menu") do
  find("#desktop-menu-button").click
end

Given("I am on the {string} page") do |path|
  path_helper = "#{path.tr(" ", "_")}_path"

  visit(send(path_helper))
end

Given("I am on the {string} page with") do |path, query|
  path_helper = "#{path.tr(" ", "_")}_path"

  params = {}

  # set query param from table first row of value
  query.headers.each_with_index do |param, index|
    value = query.rows.first[index]

    params[param] = value
  end

  visit(send(path_helper, params))
end

When("I try to visit the {string} page") do |path|
  path_helper = "#{path.downcase.tr(" ", "_")}_path"

  visit(send(path_helper))
end

When("I try to visit the {string} page for") do |path, table|
  visit_path_for(path, table)
end

When("I'm on the {string} page for") do |path, table|
  visit_path_for(path, table)
end

def visit_path_for(path, table)
  objects = []

  table.headers.each_with_index do |header, index|
    class_attribute = table.headers[index].split(" ")
    class_name = class_attribute.first
    attribute = class_attribute.last
    klass = class_name.constantize
    value = table.rows.first[index]
    entity = if attribute == "id"
      value
    else
      klass.find_by({attribute => value})
    end
    raise "Couldn't find #{class_name} with #{attribute} #{value}" if entity.blank?
    objects << entity
  end

  path_helper = "#{path.downcase.tr(" ", "_")}_path"

  visit(send(path_helper, *objects))
end

# ========
# Homepage
# ========
Given(/^I am on the homepage$/) do
  visit "/"
end

# ====
# Auth
# ====
Given(/I'm on the login page/) do
  visit new_user_session_path
end

# ====
# Gyms
# ====
Given("I am on the {string} gym page") do |gym_name|
  gym = Gym.find_by(name: gym_name)

  visit gym_path(gym)
end

When("I'm looking at the members for {string}") do |gym_name|
  gym = Gym.find_by(name: gym_name)

  visit gym_memberships_path(gym)
end

# ======
# Videos
# ======
Given("I'm on the {string} video for {string}") do |title, gym_name|
  gym = Gym.find_by(name: gym_name)
  video = Video.find_by(title: title, gym: gym)

  visit gym_video_path(gym, video)
end

# =====
# Admin
# =====
Given("I visit the admin homepage") do
  visit admin_root_path
end

Given("I'm on the admin login page") do
  visit new_admin_user_session_path
end

When("I visit the admin page for the {string} gym") do |gym_name|
  gym = Gym.find_by(name: gym_name)

  visit admin_gym_path(gym)
end
