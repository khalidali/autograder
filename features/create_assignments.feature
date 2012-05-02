@https://www.pivotaltracker.com/story/show/26594877
Feature: Create assignments
  As an instructor
  So that I can create an assignment
  I want to be able to submit an autograder

  Scenario: Create a new assignment with an authorized instructor key
    Given the instructor key "Armando" is authorized
    When "Armando" creates an assignment with the following: "student_keys=[robert, khalid, ernest]"
    Then the response should be "200"
    And the response should contain "created_at"
    And the response should not contain "ERROR"

  Scenario: Create a new assignment with an unauthorized instructor key
    Given the instructor key "Armando" is not authorized
    When "Armando" creates an assignment with the following: "student_keys=[robert, khalid, ernest]"
    Then the response should be "200"
    And the response should not contain "created_at"
    And the response should contain "ERROR"
