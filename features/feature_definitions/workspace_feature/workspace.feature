@api_test
  Feature: Project for API Testing Class (workspace)

    @smoke
    Scenario: Get workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request to
      Then I expect Status code 200

    @smoke
    Scenario: Post workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST with the json
      """
      {
        "name":"workspaceTestXYZ"
      }
      """
      Then I expect Status code 200

    @smoke @create_project @delete_project
    Scenario: PUT workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace PUT request to add project
      Then I expect Status code 200

    @smoke
    Scenario: DELETE workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace DELETE request to delete WorkspaceRequest
      Then I expect Status code 204

    @acceptance
    Scenario Outline: Verify than the created workspace was created with the same values inserted.
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST request with the json
    """
      {
        "name":"<Name>"
      }
    """
      Then I expect Status code 200
      And I expect the all inserted data workspace are the same
      Examples:
        | Name |
        | workspace-E1 |
        | workspace-E2 |
        | workspace-E3 |

    @acceptance
    Scenario Outline: Verify Kind Workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace POST request with the json
    """
      {
        "name":"<Name>"
      }
    """
      Then I expect Status code 200
      And I expect the kind of workspace is equal to workspace
      Examples:
        | Name |
        | workspace-Kind-E1 |

    @acceptance
    Scenario: Verify the all data type that return the get request to workspace are correct
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request to
      Then I expect Status code 200
      And I expect the all data type returned from workspace request are correct

    @negative
    Scenario: Verify that a workspace cannot be obtained for a non-existent workspace
      Given I have set a connection to pivotal_tracker API service
      When I send a workspace GET request for a workspace 000
      Then I expect Status code 404
      And I expect an error message from workspace