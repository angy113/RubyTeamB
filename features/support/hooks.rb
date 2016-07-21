require_relative '../../src/requests/project_request/project_request'
require_relative '../../src/requests/workspace_request/workspace_request'
require_relative '../../src/helpers/rest_client/api_rest_client'

Before('@create_project') do
  client = ApiRestClient.new
  #create the project

  json_param = {:name => "General_project_5"}

  _,$project = ProjectRequest.create_project(client,"POST",json_param.to_json)
  
end

After('@delete_project') do
  #delete  project
  client = ApiRestClient.new
  ProjectRequest.delete_project(client,"DELETE",$project.id)
end

Before('@create_workspace') do
  client = ApiRestClient.new
  #create a workspace Ericka
  json_param = {:name => "General_workspaceX"}
  $workspace = WorkspaceRequest.create_workspace(client,"POST",json_param)
end

After('@delete_workspace') do
  #delete  workspace Ericka
  client = ApiRestClient.new
  WorkspaceRequest.delete_workspace(client,"DELETE",$workspace.id)
end

Before('@create_story') do
  client = ApiRestClient.new
  #create the project
  json_param = {:name => "General_bruno06"}
  _, $story= StoriesRequest.create_stories(client,"POST",$project.id,json_param.to_json)

end

After('@delete_story') do
  #delete  project
  client = ApiRestClient.new
  ProjectRequest.delete_project(client,"DELETE",$project.id)
end
