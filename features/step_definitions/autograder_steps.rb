
Given /^an assignment with id "([^"]*)" exists$/ do |arg1|
  Assignment.create :id => arg1
end

Given /^the test db is populated$/ do
  #pending # express the regexp above with the code you wish you had
end

Given /^I allow the following keys "([^"]*)" to submit to the assignment whose id is "([^"]*)"$/ do |keys, id|
  step "I send a PUT request to \"/assignments/#{id}/add_student_keys.json\" with the following:\"student_keys=#{keys}\""
end

Given /^I upload the grading file "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^"([^"]*)" submits "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |key, code, id|
  step "I send a PUT request to \"assignments/#{id}/submit.json\" with the following: \"student_key=#{key}&submission=#{code}\""
end

When /^I retrieve all submissions to the assignment whose id is "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I retrieve all pending submissions to the assignment whose id is "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I upload the autograder "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

