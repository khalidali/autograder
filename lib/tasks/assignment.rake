namespace :assignment  do
  desc "creates an assignment with given arguments"
  task :create, [:prof_key, :student_keys, :autograder] => [:environment] do |t, args|
    root = Rails.root 
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    a = `curls -X POST -F "prof_key="#{root + args[:prof_key]}"&student_keys=[#{student}]" -F autograder=@inst_autograder.rb localhost:3000/assignments/create.json`
    puts a
    puts "'#{args[:prof_key]}!'"
    puts "'#{args[:student_keys]}!'"
    puts "'#{student}!'"
    puts "'#{args[:autograder]}!'"
    puts "'#{args[:environment]}!'"
  end
  
  desc"To change due date of an assignment"
  task :change_due_date, [:date] => [:environment] do |t, args|
    root = Rails.root 
    a = `curl -X PUT -d "due_date=#{args[:date]}" localhost:3000/assignments/1/change_due_date.json`
    puts a
    puts "'#{args[:date]}!'"
  end

  desc"To add student keys"
  task :add_student_keys, [:student_keys] => [:environment] do |t, args|
    root = Rails.root 
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    a = `curl -X PUT -d "student_keys=[#{student}]" localhost:3000/assignments/1/add_student_keys.json`
    puts a
    puts "'#{student}!'"
  end

  desc"To remove student keys"
  task :remove_student_keys, [:student_keys] => [:environment] do |t, args|
    root = Rails.root 
    puts "before => " + args[:student_keys]
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    puts "after => " + student
    a = `curl -X PUT -d "student_keys=[#{student}]" localhost:3000/assignments/1/remove_student_keys.json`
    puts a
   puts "'#{student}!'"
  end
  
  desc "Call rake task in assignment"
  task :call => [:environment]do
    Rake.application.invoke_task("assignment:create[Armando,'Khalid:Robert',student_code.rb]")
    Rake.application.invoke_task("assignment:change_due_date[01/21/11]")
    Rake.application.invoke_task("assignment:add_student_keys['Yaniv:Richael']")
    Rake.application.invoke_task("assignment:remove_student_keys['Yaniv:Richael']")
  end
end
