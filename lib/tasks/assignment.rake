namespace :assignment  do
  desc "creates an assignment with given arguments"
  task :create, [:prof_key, :student_keys, :autograder] => [:environment] do |t, args|
    root = Rails.root 
    autograder = Rails.root + "test/fixtures"
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    
    puts "Rake Task: Creates an assignment with given arguments"
    a = `curl -s -X POST -F "prof_key="#{root + args[:prof_key]}"&student_keys=[#{student}]" -F autograder=@#{autograder + args[:autograder]} /dev/null localhost:3000/assignments/create.json 2>&1`
    puts a
  end
  
  desc"To change due date of an assignment"
  task :change_due_date, [:date] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To change due date of an assignment"
    a = `curl -s -X PUT -d "due_date=#{args[:date]}" /dev/null localhost:3000/assignments/1/change_due_date.json 2>&1`
    puts a
  end

  desc"To add student keys"
  task :add_student_keys, [:student_keys] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To add student keys"
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "student_keys=[#{student}]" /dev/null localhost:3000/assignments/1/add_student_keys.json 2>&1`
    puts a
  end

  desc"To remove student keys"
  task :remove_student_keys, [:student_keys] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To remove student keys"
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "student_keys=[#{student}]" /dev/null localhost:3000/assignments/1/remove_student_keys.json 2>&1`
    puts a
  end
  
  desc "To update the autograder"
  task :update_autograder, [:autograder] => [:environment] do |t, args|
    root = Rails.root + "test/fixtures" 
    
    puts "Rake Task: To update the autograder"
    a = `curl -s -X PUT -F autograder=@#{root + args[:autograder]} /dev/null localhost:3000/assignments/1/update_autograder.json 2>&1`
    puts a
  end
  
  desc "Call rake task in assignment"
  task :call => [:environment]do
    Rake.application.invoke_task("assignment:create[Armando,'Khalid;Robert',inst_autograder.rb]")
    Rake.application.invoke_task("assignment:change_due_date[01/21/11]")
    Rake.application.invoke_task("assignment:add_student_keys[Yaniv;Richael;Robert]")
    Rake.application.invoke_task("assignment:remove_student_keys[Yaniv;Richael]")
    Rake.application.invoke_task("assignment:update_autograder[inst_autograder.rb]")
  end
end
