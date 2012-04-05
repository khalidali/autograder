
namespace :db  do
  desc "create some sample assignments"
  task :populate => :environment  do
    fake_student_keys1 = ["robert", "khalid", "ernest"]
    fake_student_keys2 = ["omar", "yaniv"]
    fake_submission = "fake_submission_code_by_" 
    
    Assignment.create(:prof_key => "armando", :due_date =>   "01/01/1969").add_student_keys(fake_student_keys1)
    Assignment.create(:prof_key => "patterson", :due_date => "01/01/1969").add_student_keys(fake_student_keys2)
    Student.find_by_student_key(fake_student_keys1[0]).add_submission(fake_submission + fake_student_keys1[0])
    Student.find_by_student_key(fake_student_keys1[1]).add_submission(fake_submission + fake_student_keys1[1])
    Student.find_by_student_key(fake_student_keys1[2]).add_submission(fake_submission + fake_student_keys1[2])
    Student.find_by_student_key(fake_student_keys2[0]).add_submission(fake_submission + fake_student_keys2[0])
    Student.find_by_student_key(fake_student_keys2[1]).add_submission(fake_submission + fake_student_keys2[1])
    

    print "database populated with sample data.\n"
  end
end
