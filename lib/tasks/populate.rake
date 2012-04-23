
namespace :db  do
  desc "create some sample assignments"
  task :populate => :environment  do
    fake_student_keys1 = "robert;khalid;ernest"
    fake_student_keys2 = "omar;yaniv"
    fake_submission = "fake_submission_code_by_" 
    
    Rake.application.invoke_task("assignment:create[Armando,robert;khalid;ernest,inst_autograder.rb]")
    Rake.application.invoke_task("assignment:create[Patterson,omar;yaniv,inst_autograder.rb]")
    Rake.application.invoke_task("submission:submit[1,robert,student_code.rb]")
    Rake.application.invoke_task("submission:submit[1,khalid,student_code.rb]")
    Rake.application.invoke_task("submission:submit[1,ernest,student_code.rb]")
    Rake.application.invoke_task("submission:submit[2,omar,student_code.rb]")
    Rake.application.invoke_task("submission:submit[2,yaniv,student_code.rb]")
    
  end
end
