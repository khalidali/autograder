@https://www.pivotaltracker.com/story/show/28719677
Feature: Authorize instructor keys
  As a website admin
  So that I can let instructor create assignments
  I want to authorize new instructor keys

    Scenario: Authorize new instructor key
      Given the super key is "1234567890"
      And the instructor key "armando" is not authorized
      When I add the new instructor key "armando"
      Then the response should be '200'
      And the response should contain "Instructor key authorized"

    Scenario: Authorize an existing instructor key
      Given the super key is "1234567890"
      And the instructor key "armando" is authorized
      When I add the new instructor key "armando"
      Then the response should be '200'
      And the response should contain "Instructor key already authorized"
      And the response should not contain "Instructor key authorized"
