namespace :assignment  do
  desc "creates an assignment with given arguments"
  task :create, [:prof_key, :student_keys, :autograder] => [:environment] do |t, args|
    root = Rails.root 
    autograder = Rails.root + "test/fixtures"
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    
    puts "Rake Task: Creates an assignment with given arguments"
    a = `curl -s -X POST /dev/null localhost:3000/assignments/create.json -F "prof_key=#{args[:prof_key]}" -F "student_keys=[#{student}]" -F autograder=@#{autograder + args[:autograder]} 2>&1`
    puts a
  end
  
  desc"To change due date of an assignment"
  task :set_due_date, [:id, :date] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To change due date of an assignment"
    a = `curl -s -X PUT -d "due_date=#{args[:date]}" /dev/null localhost:3000/assignments/#{args[:id]}/due_date.json 2>&1`
    puts a
  end
  
  desc"To get due date of an assignment"
  task :get_due_date, [:id] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To change due date of an assignment"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/#{args[:id]}/due_date.json 2>&1`
    puts a
  end
  
  desc"To list student keys"
  task :list_student_keys, [:id] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To list student keys"
    a = `curl -s -X GET  /dev/null localhost:3000/assignments/#{args[:id]}/student_keys 2>&1`
    puts a
  end
  
  desc"To remove student keys"
  task :remove_student_keys, [:id, :keys] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To remove student keys"
    student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "keys=[#{student}]" /dev/null localhost:3000/assignments/#{args[:id]}/student_keys/remove 2>&1`
    puts a
  end

  desc"To add student keys"
  task :add_student_keys, [:id, :keys] => [:environment] do |t, args|
    root = Rails.root 
    
    puts "Rake Task: To add student keys"
    student = "#{args[:keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "keys=[#{student}]" /dev/null localhost:3000/assignments/#{args[:id]}/student_keys/add 2>&1`
    puts a
  end

  desc "To set the autograder"
  task :set_autograder, [:id, :autograder] => [:environment] do |t, args|
    root = Rails.root + "test/fixtures" 
    
    puts "Rake Task: To update the autograder"
    a = `curl -s -X PUT -F autograder=@#{root + args[:autograder]} /dev/null localhost:3000/assignments/#{args[:id]}/autograder 2>&1`
    puts a
  end
  desc "To get the autograder"
  task :get_autograder, [:id] => [:environment] do |t, args|
    root = Rails.root + "test/fixtures" 
    
    puts "Rake Task: To update the autograder"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/#{args[:id]}/autograder 2>&1`
    puts a
  end
  
end
