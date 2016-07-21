@api_test
Feature: Final Project for API Testing class - COMMENTS
  @smoke @create_project @create_story
  Scenario: Verify method POST for Comments API
    Given I have set a connection to pivotal_tracker API service
    When I send an comments POST with the json2
     """
      {
        "text":"Coment-test2"
      }
    """
    Then I expect Status code 200

  @smoke
  Scenario: Verify to get an specific Comments API
    Given I have set a connection to pivotal_tracker API service
    When I send a comments GET request for a project and stories comments
    Then I expect Status code 200
  @smoke
  Scenario: Verify method PUT for Comments API
    Given I have set a connection to pivotal_tracker API service
    When I send an comments PUT request to CommentsRequest with json
    """
      {
        "text":"Coment-test1 Updated"
      }
    """
    Then I expect Status code 200

  @smoke
  Scenario: Verify method DELETE for Comments API
    Given I have set a connection to pivotal_tracker API service
    When I send an comments DELETE request to CommentsRequest
    Then I expect Status code 204



  @acceptance
  Scenario Outline: Verify the created Comments has been created with the same parameters
    Given I have set a connection to pivotal_tracker API service
    When I send an Comments POST with the json
    """
      {
        "text":"<text>"
      }
    """
    Then I expect Status code 200
    And I expect the all inserted data Comments are the same that the data sent
    Examples:
      | text |
      | Comments-01 |

  @negative
  Scenario: Verify that an Comments cannot be obtained for a non-existent project
    Given I have set a connection to pivotal_tracker API service
    When I send a Comments GET request for a project 0
    Then I expect Status code 404
    And I expect an error message to Comments

  @negative
  Scenario: Verify that an Comments cannot be obtained for a non-existent stories
    Given I have set a connection to pivotal_tracker API service
    When I send a Comments GET request for a stories 0
    Then I expect Status code 404
    And I expect an error message to Comments

  @negative
  Scenario: Verify that an Comments cannot be obtained for a non-existent comments
    Given I have set a connection to pivotal_tracker API service
    When I send a Comments GET request for a comments 0
    Then I expect Status code 404
    And I expect an error message to Comments

  @smoke @delete_project
  Scenario: Verify method DELETE for Comments API
    Given I have set a connection to pivotal_tracker API service
    When I send an comments DELETE request to CommentsRequest
    Then I expect Status code 400



