Given("my preferred language is {string}") do |language|
  @locale = case language
  when "english"
    :en
  when "french"
    :fr
  end

  page.driver.header "Accept-Language", @locale
end
