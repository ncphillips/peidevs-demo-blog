Then("I should see the {string} in {string}") do |string, locale|
  expect(page).to have_content I18n.t(string, locale: locale)
end

Then("I should see the localized {string}") do |string|
  expect(page).to have_content I18n.t(string, locale: @locale)
end

Then("I should see the following localized copy") do |table|
  table.hashes.each do |row|
    expect(page).to have_content I18n.t(row["copy"], locale: @locale)
  end
end

Then("I should see {string}") do |string|
  expect(page).to have_content string
end

Then("I should not see {string}") do |string|
  expect(page).to_not have_content string
end

Then("I should see a {string} link") do |string|
  expect(find_link(string)).to be_visible
end

Then("I should not see a {string} link") do |string|
  expect(page).to_not have_link string
end

Then("I should see an input containing {string}") do |string|
  expect(page).to have_field(with: string)
end

Then("I see an empty table in the {string} panel") do |panel_heading|
  within(:xpath, "//div[h3[contains(text(), '#{panel_heading}')]]") do |panel|
    expect(panel).to have_selector("table tbody tr", count: 0)
  end
end

Then("I see {string} in the {string} panel") do |text, panel_heading|
  within(:xpath, "//div[h3[contains(text(), '#{panel_heading}')]]") do |panel|
    expect(panel).to have_content(text)
  end
end

Then("I see {string} in the {string} section") do |text, section_heading|
  within(:xpath, "//section[h2[contains(text(), '#{section_heading}')]]") do |section|
    expect(section).to have_content(text)
  end
end

Then("I do not see {string} in the {string} section") do |text, section_heading|
  within(:xpath, "//section[h2[contains(text(), '#{section_heading}')]]") do |section|
    expect(section).to_not have_content(text)
  end
end

Then("I do not see {string} in the latest videos section") do |string|
  within("#latest-training-videos") do |section|
    expect(section).to_not have_content(string)
  end
end

Then("I should see a {string} button") do |string|
  expect(find_button(string)).to be_visible
end
