namespace :assignment do
  desc "creates an assignment with given arguments"
  task :create, [:inst_key, :student_keys, :autograder] => [:environment] do |t, args|
    root = Rails.root
    if(args[:autograder] == nil)
      autograder = Rails.root + "test/fixtures" + "inst_autograder.rb"
    else
      autograder = Rails.root + "test/fixtures" + params[:autograder]
    end
    if(args[:student_keys] == nil)
      student = "robert,khalid,ernest"
    else
      student = "#{args[:student_keys]}".gsub(/[;]/, ',')
    end
    
    puts "Rake Task: Creates an assignment with given arguments"
    a = `curl -s -X POST /dev/null localhost:3000/assignments/create.json -F "inst_key=#{args[:inst_key]}" -F "student_keys=[#{student}]" -F autograder=@#{autograder} 2>&1`
    puts a
  end
  
  desc"To change due date of an assignment"
  task :set_due_date, [:id, :inst_key, :date] => [:environment] do |t, args|
    root = Rails.root
    date = args[:date]
    date = Time.new.to_s if date == nil
    puts "Rake Task: To change due date of an assignment"
    a = `curl -s -X PUT -d "due_date=#{date}" -d "inst_key=#{args[:inst_key]}" /dev/null localhost:3000/assignments/#{args[:id]}/due_date.json 2>&1`
    puts a
  end
  
  desc"To get due date of an assignment"
  task :get_due_date, [:id, :inst_key] => [:environment] do |t, args|
    root = Rails.root
    puts "Rake Task: To change due date of an assignment"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/#{args[:id]}/due_date.json -d "inst_key=#{args[:inst_key]}" 2>&1`
    puts a
  end
  
  desc"To list student keys"
  task :list_student_keys, [:id, :inst_key] => [:environment] do |t, args|
    root = Rails.root
    
    puts "Rake Task: To list student keys"
    a = `curl -s -X GET /dev/null localhost:3000/assignments/#{args[:id]}/student_keys -d "inst_key=#{args[:inst_key]}" 2>&1`
    puts a
  end
  
  desc"To remove student keys"
  task :remove_student_keys, [:id, :inst_key, :keys] => [:environment] do |t, args|
    root = Rails.root
    
    puts "Rake Task: To remove student keys"
    student = "#{args[:keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "keys=[#{student}]" -d "inst_key=#{args[:inst_key]}" /dev/null localhost:3000/assignments/#{args[:id]}/student_keys/remove 2>&1`
    puts a
  end

  desc"To add student keys"
  task :add_student_keys, [:id, :inst_key, :keys] => [:environment] do |t, args|
    root = Rails.root
    
    puts "Rake Task: To add student keys"
    student = "#{args[:keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT -d "keys=[#{student}]" -d "inst_key=#{args[:inst_key]}" /dev/null localhost:3000/assignments/#{args[:id]}/student_keys/add 2>&1`
    puts a
  end

  desc "To set the autograder"
  task :set_autograder, [:id, :inst_key, :autograder] => [:environment] do |t, args|
    root = Rails.root + "test/fixtures"
    
    puts "Rake Task: To update the autograder"
    a = `curl -s -X PUT -F autograder=@#{root + args[:autograder]} -F "inst_key=#{args[:inst_key]}" /dev/null localhost:3000/assignments/#{args[:id]}/autograder 2>&1`
    puts a
  end
  desc "To get the autograder"
  task :get_autograder, [:id] => [:environment, :inst_key] do |t, args|
    root = Rails.root + "test/fixtures"
    
    puts "Rake Task: To update the autograder"
    a = `curl -s -X GET /dev/null -d "inst_key=#{args[:inst_key]}" localhost:3000/assignments/#{args[:id]}/autograder 2>&1`
    puts a
  end
end

