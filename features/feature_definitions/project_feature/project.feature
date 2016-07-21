@api_test
Feature: Final Project for API Testing class - PROJECT

  @smoke
  Scenario: Verify to get an specific Project API
    Given I have set a connection to pivotal_tracker API service
    When I send a project GET request
    Then I expect Status code 200

  @smoke
  Scenario: Verify method POST for Project API
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json2
    """
      {
        "name":"angy11"
      }
    """
    Then I expect Status code 200

  @smoke
  Scenario: Verify method PUT for Project API
    Given I have set a connection to pivotal_tracker API service
    When I send a project PUT request to ProjectRequest with json
    """
      {
        "name":"angy111"
      }
    """
    Then I expect Status code 200

  @smoke
  Scenario: Verify method DELETE for Project API
    Given I have set a connection to pivotal_tracker API service
    When I send a project DELETE request to ProjectRequest
    Then I expect Status code 204

  @acceptance
  Scenario: Verify that a project can be created with different json post
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json
    """
      {
         "name": "Angy Executioner",
         "week_start_day": "Monday"
      }
    """
    Then I expect Status code 200
    And I expect all data correct

  @acceptance
  Scenario Outline: Verify the created Project has been created with the same parameters
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json
    """
      {
        "name":"<Name>"
      }
    """
    Then I expect Status code 200
    And I expect the all inserted data are the same that the data sent
    Examples:
      | Name             |
      | ProjectAngy-0001 |
      | ProjectAngy-0002 |
      | ProjectAngy-0003 |

  @acceptance
  Scenario Outline: Verify format date
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json
    """
      {
        "name":"<Name>"
      }
    """
    Then I expect Status code 200
    And I expect the date format is correct
    Examples:
      | Name             |
      | ProjectAngy-0004 |

  @acceptance
  Scenario Outline: Verify Kind Project Registered
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json
    """
      {
        "name":"<Name>"
      }
    """
    Then I expect Status code 200
    And I expect the kind of project is equal to project
    Examples:
      | Name             |
      | ProjectAngy-0005 |

  @acceptance
  Scenario Outline: Verify that the project_id is the same that I have sent
    Given I have set a connection to pivotal_tracker API service
    When I send a project POST with the json
    """
      {
        "name":"<Name>"
      }
    """
    Then I expect Status code 200
    And I expect the project_id is the same
    Examples:
      | Name             |
      | ProjectAngy-0006 |

  @acceptance
  Scenario: Verify the all data type that return the get request are correct
    Given I have set a connection to pivotal_tracker API service
    When I send a project GET request
    Then I expect Status code 200
    And I expect the all data type returned from project request are correct

  @negative
  Scenario: Verify that a project cannot be obtained for a non-existent project
    Given I have set a connection to pivotal_tracker API service
    When I send a project GET request for a project 0
    Then I expect Status code 404
    And I expect an error message from project


  @negative
  Scenario: Verify that is not possible to add a Project with empty data
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative POST with the json
    """
      {
        "name":""
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem unless create_sample is true, this endpoint requires the parameter: name

  @negative
  Scenario: Verify that is not possible to add a project with a name more than 50 characters
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative POST with the json
    """
      {
        "name":"HelloHelloHelloHelloHelloHelloHelloHelloHelloHello."
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem This string is too long:  'HelloHelloHelloHelloHelloHelloHelloHelloHelloHello.'

  @negative
  Scenario: Verify that is not possible to add a project with a int data type name
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative POST with the json
    """
      {
        "name":1234
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem 'name' must be a string

  @negative
  Scenario: Verify that is not possible to add a project with an attribute different to name that neither exist too
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative POST with the json
    """
      {
        "namesss":"1234"
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem this endpoint cannot accept the parameter: namesss

  @negative @create_project
  Scenario: Verify that is not possible to edit a project with an attribute different to name that neither exist too
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with the json
    """
      {
        "namesss":"1234"
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem this endpoint requires at least one of the following parameters: account_id, accounting_type, atom_enabled, automatic_planning, bugs_and_chores_are_estimatable, description, enable_incoming_emails, enable_tasks, featured, initial_velocity, iteration_length, name, number_of_done_iterations_to_show, point_scale, profile_content, project_type, public, start_date, time_zone, velocity_averaged_over, week_start_day

  @negative
  Scenario: Verify that is not possible to edit a Project with empty data
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with the json
    """
      {
        "name":""
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem Name can't be blank


  @negative
  Scenario: Verify that is not possible to eit a project with a name more than 50 characters
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with the json
    """
      {
        "name":"HelloHelloHelloHelloHelloHelloHelloHelloHelloHello."
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem This string is too long:  'HelloHelloHelloHelloHelloHelloHelloHelloHelloHello.'

  @negative @delete_project
  Scenario: Verify that is not possible to edit a project with a int data type name
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with the json
    """
      {
        "name":1234
      }
    """
    Then I expect Status code 400
    And I expect the project error message One or more request parameters was missing or invalid.
    And I expect the project error code invalid_parameter
    And I expect the project error kind error
    And I expect the project error general problem 'name' must be a string

  @negative
  Scenario: Verify that is not possible to edit a project sending 0 as id project
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with 0 project id and with the json
    """
      {
        "name":"Project Updated"
      }
    """
    Then I expect Status code 404
    And I expect the project error code unfound_resource
    And I expect the project error kind error
    And I expect the project error message The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree.

  @negative
  Scenario: Verify that is not possible to edit a project sending an non-existing project id
    Given I have set a connection to pivotal_tracker API service
    When I send a project negative PUT with 22 project id and with the json
    """
      {
        "name":"Project Updated"
      }
    """
    Then I expect Status code 403
    And I expect the project error code unauthorized_operation
    And I expect the project error kind error
    And I expect the project error message Authorization failure.
    And I expect the project error general problem You aren't authorized to access the requested resource.
    And I expect the project error possible fix Your project permissions are determined on the Project Membership page. If you are receiving this error you may be trying to access the wrong project, or the project API access is disabled, or someone listed as the project's Owner needs to change your membership type.

  @negative
  Scenario: Verify that is not possible to delete a non-existing project
    Given I have set a connection to pivotal_tracker API service
    When I send a project DELETE request with the wrong project id 22
    Then I expect Status code 403
    And I expect the project error code unauthorized_operation
    And I expect the project error kind error
    And I expect the project error message Authorization failure.
    And I expect the project error general problem You aren't authorized to access the requested resource.
    And I expect the project error possible fix Your project permissions are determined on the Project Membership page. If you are receiving this error you may be trying to access the wrong project, or the project API access is disabled, or someone listed as the project's Owner needs to change your membership type.

