@https://www.pivotaltracker.com/story/show/26594877
Feature: Create assignments
  As an instructor
  So that I can create an assignment
  I want to be able to submit an autograder

  Scenario: Create a new assignment
    When I send a POST request to "/assignments/create.json" with the following:"prof_key=armando&student_keys=[robert, khalid, ernest]"
    Then the response should be "200"
    And the response should contain "Assignment Created"