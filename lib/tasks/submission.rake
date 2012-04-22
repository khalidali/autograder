namespace :submission  do
  desc "To submit an assignment with a student_key"
  task :submit, [:student_key, :submission] => [:environment] do |t, args|
    a = `curl -X PUT -d "student_key=#{args[:student_key]}&submission=#{args[:submission_key]}" localhost:3000/assignments/1/submit.json`
    puts a
    puts "'#{args[:student]}!'"
    puts "'#{args[:submission]}!'"
  end
  
  desc "To retrieve all submissions to the assignment"
  task :retrieve_all_submissions  => [:environment] do |t, args|
    a = `curl -X GET localhost:3000/assignments/1/retrieve_all_submissions.json`
    puts a
  end

  desc "To retrieve submissions by status"
  task :retrieve_submissions_by_status, [:status]  => [:environment] do |t, args|
    status = "#{args[:status]}".gsub(/[:]/, ',')
    a = `curl -X GET  -d "status="#{student}"" localhost:3000/assignments/1/retrieve_submissions_by_status.json`
    puts a
    puts "'#{args[:status]}!'"
    puts "'#{status}!'"
  end

  desc "To retrieve submissions by student_key"
  task :retrieve_submissions_by_student_key, [:student_key]  => [:environment] do |t, args|
    student_key = "#{args[:student_key]}".gsub(/[;]/, ',')
    a = `curl -X GET  -d "student_key="#{student}"" localhost:3000/assignments/1/retrieve_submission_by_student_key.json`
    puts a
    puts "'#{args[:student_key]}!'"
    puts "'#{student}!'"
  end
  
  desc "To update the submission (this is called automatically by the node when its done grading)"
  task :update_sumission_status, [:status]  => [:environment] do |t, args|
    a = `curl -X PUT localhost:3000/submissions/1/update_status.json  -F output=@output -F status='#{args[:status]}'`
    puts a
    puts "'#{args[:status]}!'"
  end
  
    desc "Call rake task in assignment"
  task :call do
    Rake.application.invoke_task("submission:submit['Robert',submission]")
    Rake.application.invoke_task("submission:retrieve_all_submissions")
    Rake.application.invoke_task("submission:retrieve_submissions_by_status[pending]")
    Rake.application.invoke_task("submission:retrieve_submissions_by_student_key['Robert']")
    Rake.application.invoke_task("submission:update_sumission_status[complete]")
  end
end
