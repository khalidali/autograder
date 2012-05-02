@https://www.pivotaltracker.com/story/show/27679539
Feature: Change assignment due date
  As an instructor
  So that I extend the assignment deadline
  I want to change the assignment due date

    Scenario: Changing assignment due date
      Given an assignment with id "1" exists for instructor "Armando"
      And "Armando" changes the due date of assignment 1 to "2012-04-29 19:50:05 -0700"
      Then the response should be "200"
      And I print the response
      And the response should contain "due_date"
      And the response should not contain "ERROR"
