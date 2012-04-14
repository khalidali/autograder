#!/usr/bin/env ruby

#files = STDIN.read

#puts files


puts "ID    : " + ARGV[0]
puts "GRADER: " + ARGV[1]
puts "SUBMIS: " + ARGV[2]


autograder = File.new("tmp_autograder.rb", "w+" )
autograder.write(ARGV[1])
autograder.chmod(0777)
autograder.close

student_code = File.new("tmp_student_code.rb", "w+" )
student_code.write(ARGV[2])
student_code.chmod(0777)
student_code.close

puts "now I'm gonna run"

#output = `#{ARGV[1]} #{ARGV[2]}`
#output = `/tmp/inst_autograder.rb #{ARGV[2]}`

output = `./tmp_autograder.rb tmp_student_code.rb`

f = File.new("output", "w+")
f.syswrite(output)
f.close


system("curl -X PUT localhost:3000/submissions/#{ARGV[0]}/update_status.json  -F output=@output -F status='complete'")

File.delete("tmp_autograder.rb")
File.delete("tmp_student_code.rb")
File.delete("output")
puts "all deleted"

