namespace :submission  do
  desc "To submit an assignment with a student_key"
  task :submit, [:student_key, :submission] => [:environment] do |t, args|
    puts "Rake Task: To submit an assignment with a student_key"
    submission = Rails.root + "test/fixtures"
    a = `curl -s -X PUT /dev/null localhost:3000/assignments/1/submit.json -F submission=@#{submission + args[:submission]} -F "student_key=#{args[:student_key]}" 2>&1`
    puts a
  end

  desc "To retrieve all submissions to the assignment"
  task :retrieve_all_submissions  => [:environment] do |t, args|
    puts "Rake Task: To retrieve all submissions to the assignment"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/1/retrieve_all_submissions.json 2>&1`
    puts a
  end

  desc "To retrieve submissions by status"
  task :retrieve_submissions_by_status, [:status]  => [:environment] do |t, args|
    status = "#{args[:status]}".gsub(/[:]/, ',')
    
    puts "Rake Task: To retrieve submissions by status"
    a = `curl -s -X GET  -d "status="#{status}"" /dev/null localhost:3000/assignments/1/retrieve_submissions_by_status.json 2>&1`
    puts a
  end

  desc "To retrieve submissions by student_key"
  task :retrieve_submissions_by_student_key, [:student_key]  => [:environment] do |t, args|
    student_key = "#{args[:student_key]}".gsub(/[;]/, ',')
    
    puts "Rake Task: To retrieve submissions by student_key"
    a = `curl -s -X GET  -d "student_key="#{student_key}"" /dev/null localhost:3000/assignments/1/retrieve_submission_by_student_key.json 2>&1`
    puts a
  end
  
  desc "To update the submission (this is called automatically by the node when its done grading)"
  task :update_sumission_status, [:output, :status]  => [:environment] do |t, args|
    path = Rails.root + "test/fixtures"
    puts "Rake Task: To update the submission (this is called automatically by the node whe its done grading)"
    a = `curl -s -X PUT /dev/null localhost:3000/submissions/1/update_status.json  -F output=@#{path + args[:output]} -F status='#{args[:status]}' 2>&1`
    puts a
  end
  
  desc "Call rake task in assignment"
  task :call do
    Rake.application.invoke_task("submission:submit[Robert,student_code.rb]")
    Rake.application.invoke_task("submission:retrieve_all_submissions")
    Rake.application.invoke_task("submission:retrieve_submissions_by_status[pending]")
    Rake.application.invoke_task("submission:retrieve_submissions_by_student_key[Robert]")
    Rake.application.invoke_task("submission:update_sumission_status[output,complete]")
  end
end
