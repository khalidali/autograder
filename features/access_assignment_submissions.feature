@https://www.pivotaltracker.com/story/show/26594895
Feature: Access assignment submissions
  As an instructor
  So that I can control who can submit to an assignment
  I want to be able to add/remove keys to an assignment

    Scenario: Accessing assignment submissions
      Given an assignment with id "1" exists for instructor "Armando"
      And "Armando" adds the following student keys to assignment 1: omar, yaniv
      And "omar" submits "student_code.rb" to the assignment whose id is "1"
      When "Armando" retrieves all submissions for assignment 1
      Then the response should be "200"
      And the response should contain "omar"
      And the response should not contain "robert"
