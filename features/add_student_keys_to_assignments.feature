@https://www.pivotaltracker.com/story/show/27669805
Feature: Add student keys to assignments
  As an instructor
  So that I can control which students can submit assignments
  I would like to add student keys to an assignment
  
  Background:
    Given an assignment with id "1" exists for instructor "Armando"

    Scenario: Adding student keys to an assignment
      When "Armando" adds the following student keys to assignment 1: omar, robert
      Then the response should be "200"
      And the response should contain "added"
      And the response should not contain "ERROR"

    Scenario: Adding student keys to an assignment
      Given the student key "omar" is authorized for assignment "1"
      When "Armando" adds the following student keys to assignment 1: omar
      Then the response should be "200"
      And the response should not contain "added"
      And the response should contain "ERROR"
