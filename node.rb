#!/usr/bin/env ruby

#files = STDIN.read

#puts files

puts "ID    : " + ARGV[0]
puts "GRADER: " + ARGV[1]
puts "SUBMIS: " + ARGV[2]

'''
file1 = File.open("/tmp/inst_autograder.rb", "r" )
file1.chmod(0111)
file1.close

file2 = File.open(ARGV[2], "r" )
file2.chmod(0111)
file2.close
'''
puts "now I'm gonna run"

output = `#{ARGV[1]} #{ARGV[2]}`
#output = `/tmp/inst_autograder.rb #{ARGV[2]}`

f = File.new("output", "w+")
f.syswrite(output)
f.close


system("curl -X PUT localhost:3000/submissions/#{ARGV[0]}/update_status  -F output=@output -F status='complete'")

