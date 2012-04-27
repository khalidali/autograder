@https://www.pivotaltracker.com/story/show/28648815
Feature: Late Submissions
  As an instructor
  So that I can allow late submissions
  I want to set another due date for late submissions

    Scenario: Change late submission due date
      Giving an assignment with if "1" exists
      And I change the late submission due date of assignment 1 to 01/01/99
      Then the response should be '200'
      And the response should contain "New Late Due Date"



