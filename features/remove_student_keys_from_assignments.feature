@https://www.pivotaltracker.com/story/show/27669815
Feature: Remove student keys from assignments
  As an instructor
  So that I can control which students cannot submit assignments
  I would like to remove student keys from an assignment

    Scenario: Removing student keys from an assignment
      Given an assignment with id "1" exists for instructor "Armando"
      And "Armando" adds the following student keys to assignment 1: omar, yaniv
      And the response should contain "added"
      And "Armando" removes the following student keys to assignment 1: omar, yaniv
      Then the response should be "200"
      And the response should contain "removed"
