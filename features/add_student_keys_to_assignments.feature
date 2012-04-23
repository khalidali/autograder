@https://www.pivotaltracker.com/story/show/27669805
Feature: Add student keys to assignments
  As an instructor
  So that I can control which students can submit assignments
  I would like to add student keys to an assignment

    Scenario: Adding student keys to an assignment
      Given an assignment with id "1" exists
      And I add the following student keys to assignment 1: omar, yaniv
      Then the response should be "200"
      And the response should contain "Student Keys Added"
