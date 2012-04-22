@https://www.pivotaltracker.com/story/show/26594929
Feature: Retrieve autograder output
  As an instructor
  So that I can see the students results
  I want to be able to retrieve the autograder's output

  Background:
  Given the test db is populated
  Given an assignment with id "1" exists
  And I allow the following keys "" to submit to the assignment whose id is "1"
  And I upload the grading file "" to the assignment whose id is "1"
  And "omar" submits

    Scenario: Retrieve all submission for an assignment
      When I retrieve all submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "All submissions"

    Scenario: Retrieve all pending submission for an assignment
      When I retrieve all pending submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "All pending submissions"


    Scenario: Retrieve all completed submission for an assignment
      When I retrieve all pending submissions to the assignment whose id is "1"
      Then the response should be "200"
      And the response should contain "All completed submissions"


