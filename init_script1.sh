#!/bin/sh

curl -X POST -d "prof_key=armando&student_keys=[robert, khalid, ernest]" localhost:3001/assignments/create.json
curl -X PUT -d "student_key=robert&submission=codesupercode" localhost:3001/assignments/1/submit.json
