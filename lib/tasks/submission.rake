namespace :submission  do
  desc "To submit an assignment with a student_key"
  task :submit, [:id, :key, :submission] => [:environment] do |t, args|
    puts "Rake Task: To submit an assignment with a student_key"
    submission = Rails.root + "test/fixtures"
    a = `curl -s -X PUT /dev/null localhost:3000/assignments/#{args[:id]}/submit.json -F submission=@#{submission + args[:submission]} -F "key=#{args[:key]}" 2>&1`
    puts a
  end

  desc "To retrieve all submissions to the assignment"
  task :retrieve_all_submissions, [:id]  => [:environment] do |t, args|
    puts "Rake Task: To retrieve all submissions to the assignment"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/#{args[:id]}/retrieve_all_submissions.json 2>&1`
    puts a
  end

  desc "To retrieve submissions by status"
  task :retrieve_submissions_by_status, [:id, :status]  => [:environment] do |t, args|
    status = "#{args[:status]}".gsub(/[:]/, ',')
    
    puts "Rake Task: To retrieve submissions by status"
    a = `curl -s -X GET  -d "status="#{status}"" /dev/null localhost:3000/assignments/#{args[:id]}/retrieve_submissions_by_status.json 2>&1`
    puts a
  end

  desc "To retrieve submissions by student_key"
  task :retrieve_submissions_by_student_key, [:id, :key]  => [:environment] do |t, args|
    key = "#{args[:key]}".gsub(/[;]/, ',')
    
    puts "Rake Task: To retrieve submissions by student_key"
    a = `curl -s -X GET  -d "key="#{key}"" /dev/null localhost:3000/assignments/#{args[:id]}/retrieve_submission_by_student_key.json 2>&1`
    puts a
  end
  
  desc "To update the submission (this is called automatically by the node when its done grading)"
  task :update_submission_status, [:id, :output, :status]  => [:environment] do |t, args|
    path = Rails.root + "test/fixtures"
    puts "Rake Task: To update the submission (this is called automatically by the node whe its done grading)"
    a = `curl -s -X PUT /dev/null localhost:3000/submissions/#{args[:id]}/update_status.json  -F output=@#{path + args[:output]} -F status='#{args[:status]}' 2>&1`
    puts a
  end
  
end
