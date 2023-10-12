require "simplecov"
SimpleCov.start "rails" do
  add_filter "/features/"
  add_filter "/step_definitions/"
end
