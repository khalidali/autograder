@https://www.pivotaltracker.com/story/show/26594857
Feature: Submit assignments
  As a student
  So that I can turn in my assignment
  I want to be able to submit my assignment

    Scenario: Submit an assignment with a valid submission key
      Given an assignment with id "1" exists
      And I send a PUT request to "/assignments/1/add_student_keys.json" with the following:"student_keys=[omar, yaniv]"
      When I send a PUT request to "assignments/1/submit.json" with the following: "student_key=omar&submission=codesupercode"
      Then the response should be "200"
      And the response should contain "Submission successful"

    Scenario: Submit an assignment with an invalid submission key
      Given an assignment with id "1" exists
      And I send a PUT request to "/assignments/1/add_student_keys.json" with the following:"student_keys=[omar, yaniv]"
      When I send a PUT request to "assignments/1/submit.json" with the following: "student_key=robert&submission=codesupercode"
      Then the response should be "200"
      And the response should contain "Submission failed"
