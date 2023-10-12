Given(/I fill out the form with/) do |table|
  table.hashes.first.each do |field, value|
    fill_in field, with: value
  end
end

Given("I fill out the {string} form with") do |form_id, table|
  submit_form_with(form_id, table)
end

When("I submit the {string} with") do |form_id, table|
  submit_form_with(form_id, table)
end

When("I fill in the {string} field with {string}") do |field, value|
  fill_in field, with: value, visible: :all
end

# =============
# Select Fields
# =============
When("I select {string} from the {string} dropdown") do |option_text, field_label|
  find(:select, field_label).find(:option, option_text).select_option
end

def submit_form_with(form_id, table)
  table.hashes.first.each do |field, value|
    fill_in field, with: value
  end

  find(form_id).click
end

When("I uncheck the {string} checkbox") do |checkbox_label|
  uncheck checkbox_label
end

Then("the {string} checkbox should be unchecked") do |checkbox_label|
  expect(page).to have_unchecked_field(checkbox_label)
end

When("I add the {string} a file to the {string} field") do |filename, field_id|
  attach_file(field_id, Rails.root.join("spec", "fixtures", filename)) # Adjust the path to your test CSVa
end
