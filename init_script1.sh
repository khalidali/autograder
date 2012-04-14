#!/bin/sh


curl -X POST -d "prof_key=armando&student_keys=[robert, khalid, ernest]" localhost:3000/assignments/create.json
curl -X PUT -F autograder=@inst_autograder.rb localhost:3000/assignments/1/update_autograder.json
curl -X PUT localhost:3000/assignments/1/submit.json -F submission=@student_code.rb -F "student_key=robert"

