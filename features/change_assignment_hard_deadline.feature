@https://www.pivotaltracker.com/story/show/28648815
Feature: Change assignment due date
  As an instructor
  So that I limit late assignment submissions past a certain date
  I want to change the assignment hard deadline
  
  Background:
    Given an assignment with id "1" exists for instructor "Armando"

    Scenario: Changing assignment hard deadline to a valid date
      When "Armando" changes the hard deadline of assignment 1 to "2012-04-29 19:50:05 -0700"
      Then the response should be "200"
      And the response should contain "hard_deadline"
      And the response should not contain "ERROR"

    Scenario: Changing assignment hard deadline to an invalid date
      When "Armando" changes the hard deadline of assignment 1 to "abcdefg"
      Then the response should be "200"
      And the response should not contain "hard_deadline"
      And the response should contain "ERROR"
