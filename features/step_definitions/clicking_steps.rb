When("I click {string}") do |string|
  click_on(text)
end

When("click {string}") do |text|
  click_on(text)
end

When("click the {string} button") do |text|
  first(:button, text).click
end

When("I click the {string} link") do |text|
  first(:link, text).click
end

When("I click the {string} link in the {string} section.") do |text, section_heading|
  within(:xpath, "//section[h2[contains(text(), '#{section_heading}')]]") do
    click_link(text)
  end
end

When("they click the {string} button") do |text|
  first(:button, text).click
end

When("I click the {string} button") do |text|
  first(:button, text).click
end
