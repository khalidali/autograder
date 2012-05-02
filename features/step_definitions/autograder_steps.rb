Given /^an assignment with id "([^"]*)" exists for instructor "([^"]*)"$/ do |id, inst|
  instructor = Instructor.create :key => inst
  instructor.assignments << Assignment.create(:id => id, :submissions_limit => 0)
  instructor.save
end

Given /^"([^"]*)" allows the following keys "([^"]*)" to submit to the assignment whose id is "([^"]*)"$/ do |inst, keys, id|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/add.json\" with the following:\"inst_key=#{inst}&keys=[#{keys}]\""
end

Given /^"([^"]*)" submits "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |key, code, id|
  put "assignments/#{id}/submit.json", "key"=> key,  "submission" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + code)
end

When /^"([^"]*)" retrieves all submissions to the assignment whose id is "([^"]*)"$/ do |inst, id|
  get "assignments/#{id}/submissions?inst_key=#{inst}"
end

When /^"([^"]*)" retrieves all "([^"]*)" submissions to the assignment whose id is "([^"]*)"$/ do |inst, status, id|
  get "assignments/#{id}/submissions?inst_key=#{inst}", "status" => status
end

When /^"([^"]*)" uploads the autograder "([^"]*)" to the assignment whose id is "([^"]*)"$/ do |inst, autograder, id|
  put "assignments/#{id}/autograder", "autograder" => Rack::Test::UploadedFile.new(Rails.root + "test/fixtures/" + autograder), "inst_key" => inst
end

And /^"([^"]*)" adds the following student keys to assignment (\d+): (.*)$/ do |inst, id, keys|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/add.json\" with the following:\"inst_key=#{inst}&keys=[#{keys}]\""
end

When /^"([^"]*)" retrieves all submissions for assignment (\d+)$/ do |inst, id|
  step "I send a GET request for \"/assignments/#{id}/submissions?inst_key=#{inst}\""
end

When /^"([^"]*)" changes the due date of assignment (\d+) to "(.*)"$/ do |inst, id, date|
  step "I send a PUT request to \"/assignments/#{id}/due_date.json\" with the following: \"inst_key=#{inst}&due_date=#{date}\""
end

When /^"([^"]*)" creates an assignment with the following: "([^"]*)"$/ do |inst, params|
  step "I send a POST request to \"/assignments/create.json\" with the following:\"inst_key=#{inst}&#{params}\""
end

When /^"([^"]*)" removes the following student keys to assignment (\d+): (.*)$/ do |inst, id, keys|
  step "I send a PUT request to \"/assignments/#{id}/student_keys/remove.json\" with the following:\"inst_key=#{inst}&keys=[#{keys}]\""
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

Then /^"([^"]*)" changes the late submission due date of assignment (\d+) to (.*)$/ do |inst, arg1, arg2|
  step "I send a PUT request to \"/assignments/#{arg1}/hard_deadline\" with the following: \"inst_key=#{inst}&hard_deadline=#{arg2}\""
end

Given /^all submissions of assignment "([^"]*)" are completed$/ do |arg1|
  Assignment.find(arg1).submissions.each { |s| s.status = 'completed' and s.save }
end

