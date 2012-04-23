
Given /^an assignment with id "([^"]*)" exists$/ do |arg1|
  Assignment.create :id => arg1
end

Given /^the test db is populated$/ do
  #pending # express the regexp above with the code you wish you had
end

Given /^I allow the following keys "([^"]*)" to submit to the assignment whose id is "([^"]*)"$/ do |keys, id|
  step "I send a PUT request to \"/assignments/#{id}/add_student_keys.json\" with the following:\"student_keys=#{keys}\""
end


Given /^"([^"]*)" submits "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |key, code, id|
  put "assignments/#{id}/submit.json", "student_key"=> key,  "submission" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + code)
end

When /^I retrieve all submissions to the assignment whose id is "([^"]*)"$/ do |id|
  get "assignments/#{id}/retrieve_all_submissions.json"
end

When /^I retrieve all "([^"]*)" submissions to the assignment whose id is "([^"]*)"$/ do |status, id|
  get "assignments/#{id}/retrieve_submissions_by_status.json", "status" => status
end


When /^I upload the autograder "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |autograder, id|
  put "assignments/#{id}/update_autograder.json", "autograder" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + autograder)
end



And /^I add the following student keys to assignment (\d+): (.*)$/ do |id, keys|
  step "I send a PUT request to \"/assignments/#{id}/add_student_keys.json\" with the following:\"student_keys=[#{keys}]\""
end

When /^I retrieve all submissions for assignment (\d+)$/ do |id|
  step "I send a GET request for \"/assignments/#{id}/retrieve_all_submissions.json\""
end

When /^I change the due date of assignment (\d+) to (.*)$/ do |id, date|
  step "I send a PUT request to \"/assignments/#{id}/change_due_date.json\" with the following: \"due_date=#{date}\""
end

When /^I create an assignment with the following: "([^"]*)"$/ do |params|
  step "I send a POST request to \"/assignments/create.json\" with the following:\"#{params}\""
end

When /^I remove the following student keys to assignment (\d+): (.*)$/ do |id, keys|
  step "I send a PUT request to \"/assignments/#{id}/remove_student_keys.json\" with the following:\"student_keys=#{keys}\""
end

