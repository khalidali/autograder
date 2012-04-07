@https://www.pivotaltracker.com/story/show/26594895
Feature: Access assignment submissions
  As an instructor
  So that I can control who can submit to an assignment
  I want to be able to add/remove keys to an assignment

    Scenario: Accessing assignment submissions
      Given an assignment with id "1" exists
      And I send a PUT request to "/assignments/1/add_student_keys.json" with the following:"student_keys=[omar, yaniv]"
      And I send a PUT request to "assignments/1/submit.json" with the following: "student_key=omar&submission=codesupercode"
      When I send a GET request for "/assignments/1/retrieve_all_submissions.json"
      Then the response should be "200"
      And the response should contain "codesupercode"
      And the response should contain "omar"
      And the response should not contain "robert"
