@https://www.pivotaltracker.com/story/show/26594857
Feature: Submit assignments
  As a student
  So that I can turn in my assignment
  I want to be able to submit my assignment

    Scenario: Submit an assignment with a valid submission key
      Given an assignment with id "1" exists
      And I add the following student keys to assignment 1: omar, yaniv
      When "omar" submits "student_code.rb" to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "created_at"
      And the response should not contain "ERROR"

    Scenario: Submit an assignment with an invalid submission key
      Given an assignment with id "1" exists
      And I add the following student keys to assignment 1: omar, yaniv
      When "robert" submits "student_code.rb" to the assignment whose id is "1"
      Then the response should be "200"
      And the response should not contain "created_at"
      And the response should contain "ERROR"
