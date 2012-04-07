@https://www.pivotaltracker.com/story/show/27679539
Feature: Change assignment due date
  As an instructor
  So that I extend the assignment deadline
  I want to change the assignment due date

    Scenario: Changing assignment due date
      Given an assignment with id "1" exists
      When I send a PUT request to "/assignments/1/change_due_date.json" with the following: "due_date=01/02/99"
      Then the response should be "200"
      And the response should contain "New Due Date"
