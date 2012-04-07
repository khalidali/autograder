@https://www.pivotaltracker.com/story/show/27669815
Feature: Remove student keys from assignments
  As an instructor
  So that I can control which students cannot submit assignments
  I would like to remove student keys from an assignment

    Scenario: Removing student keys from an assignment
      Given an assignment with id "1" exists
      And I send a PUT request to "/assignments/1/add_student_keys.json" with the following: "student_keys=[omar, yaniv]"
      And the response should contain "Student Keys Added"
      When I send a PUT request to "/assignments/1/remove_student_keys.json" with the following:"student_keys=[omar, yaniv]"
      Then the response should be "200"
      And the response should contain "Student Keys Removed"
