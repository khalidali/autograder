@https://www.pivotaltracker.com/story/show/28648815
Feature: Late Submissions
  As an instructor
  So that I can allow late submissions
  I want to set another due date for late submissions

    Scenario: Change late submission due date
      Given an assignment with id "1" exists for instructor "Armando"
      When "Armando" changes the late submission due date of assignment 1 to 2012-04-29 19:50:05 -0700
      Then the response should be "200"
      And the response should contain "hard_deadline"



