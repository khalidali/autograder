namespace :instructor do
  desc"To list instructor keys"
  task :list_instructor_keys, [:super_key] => [:environment] do |t, args|

    puts "Rake Task: To list instructor keys"
    a = `curl -s -X GET /dev/null localhost:3000/instructors -d "super_key=#{args[:super_key]}" 2>&1`
    puts a
  end
  
  desc"To add instructor keys"
  task :add_instructor_keys, [:super_key, :keys] => [:environment] do |t, args|
    root = Rails.root
    
    puts "Rake Task: To add instructor keys"
    instructors = "#{args[:keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT /dev/null localhost:3000/instructors/authorize -d "super_key=#{args[:super_key]}" -d "keys=[#{instructors}]" 2>&1`
    puts a
  end
  
  
  desc"To remove instructor keys"
  task :remove_instructor_keys, [:super_key, :keys] => [:environment] do |t, args|
    root = Rails.root
    
    puts "Rake Task: To remove instructor keys"
    instructors = "#{args[:keys]}".gsub(/[;]/, ',')
    a = `curl -s -X PUT /dev/null localhost:3000/instructors/deauthorize -d "super_key=#{args[:super_key]}" -d "keys=[#{instructors}]" 2>&1`
    puts a
  end
  

  
end

