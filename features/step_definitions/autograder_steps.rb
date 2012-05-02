
Given /^an assignment with id "([^"]*)" exists for instructor "([^"]*)"$/ do |arg1, arg2|
  instructor = Instructor.create :key => arg2
  instructor.assignments << Assignment.create(:id => arg1)
  instructor.save
end

Given /^the test db is populated$/ do
  #pending # express the regexp above with the code you wish you had
end

Given /^I allow the following keys "([^"]*)" to submit to the assignment whose id is "([^"]*)"$/ do |keys, id|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/add.json\" with the following:\"keys=[#{keys}]\""
end


Given /^"([^"]*)" submits "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |key, code, id|
  put "assignments/#{id}/submit.json", "key"=> key,  "submission" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + code)
end

When /^I retrieve all submissions to the assignment whose id is "([^"]*)"$/ do |id|
  get "assignments/#{id}/submissions"
end

When /^I retrieve all "([^"]*)" submissions to the assignment whose id is "([^"]*)"$/ do |status, id|
  get "assignments/#{id}/submissions", "status" => status
end


When /^I upload the autograder "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |autograder, id|
  put "assignments/#{id}/autograder", "autograder" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + autograder)
end



And /^I add the following student keys to assignment (\d+): (.*)$/ do |id, keys|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/add.json\" with the following:\"keys=[#{keys}]\""
end

When /^I retrieve all submissions for assignment (\d+)$/ do |id|
  step "I send a GET request for \"/assignments/#{id}/submissions\""
end

When /^I change the due date of assignment (\d+) to "(.*)"$/ do |id, date|
  step "I send a PUT request to \"/assignments/#{id}/due_date.json\" with the following: \"due_date=#{date}\""
end

When /^I create an assignment with the following: "([^"]*)"$/ do |params|
  step "I send a POST request to \"/assignments/create.json\" with the following:\"#{params}\""
end

When /^I remove the following student keys to assignment (\d+): (.*)$/ do |id, keys|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/remove.json\" with the following:\"keys=[#{keys}]\""
end

And /^I print the response/ do
  puts last_response.body
end
Then /^I should get valid JSON$/ do 
  assert_nothing_raised do 
    ActiveSupport::JSON.decode(@response.body) 
  end
end

Given /^the super key is "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^the instructor key "([^"]*)" is not authorized$/ do |arg1|
  Instructor.find_by_key(arg1).destroy
end

When /^I add the new instructor key "([^"]*)"$/ do |arg1|
  step "I send a PUT request to \"/instructors/authorize\" with the following: \"keys=[#{arg1}]\""
end

Given /^the instructor key "([^"]*)" is authorized$/ do |arg1|
  Instructor.create(:key => arg1)
end

Then /^I change the late submission due date of assignment (\d+) to (.*)$/ do |arg1, arg2|
  step "I send a PUT request to \"/assignments/#{arg1}/hard_deadline\" with the following: \"hard_deadline=#{arg2}\""
end

