@https://www.pivotaltracker.com/story/show/26594929
Feature: Retrieve autograder output
  As an instructor
  So that I can see the students results
  I want to be able to retrieve the autograder's output

  Background:
  Given an assignment with id "1" exists for instructor "Armando"
  And "Armando" allows the following keys "omar, yaniv" to submit to the assignment whose id is "1"
  And "Armando" uploads the autograder "inst_autograder.rb" to the assignment whose id is "1"
  And "omar" submits "student_code.rb" to the assignment whose id is "1"

    Scenario: Retrieve all submission for an assignment
      When "Armando" retrieves all submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "student_key"

    Scenario: Retrieve all pending submission for an assignment
      When "Armando" retrieves all "pending" submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "pending"

    Scenario: Retrieve all completed submission for an assignment
      Given all submissions of assignment "1" are completed
      When "Armando" retrieves all "completed" submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "completed"
