@https://www.pivotaltracker.com/story/show/28057493
Feature: Update assignment's autograder program
  As an instructor
  So that I can make changes to the autograder program
  I want to be able to upload a new autograder file to my assignment

    Scenario: Updating the autograder program
      Given an assignment with id "1" exists
      When I upload the autograder "inst_autograder.rb" to the assignment whose id is "1"
      Then the response should be "200"
      And the response should not contain "ERROR"
