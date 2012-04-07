
Given /^an assignment with id "([^"]*)" exists$/ do |arg1|
  Assignment.create :id => arg1
end
