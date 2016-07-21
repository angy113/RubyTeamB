require_relative '../../../src/helpers/data_helper'
require_relative '../../../src/requests/workspace_request/workspace_request'
require_relative '../../../src/helpers/rest_client/api_rest_client'

# SMOKES
When(/^I send a workspace (GET) request to$/) do |method|
    @http_response = WorkspaceRequest.get_workspace(@client, method)
    array_workspace_json = JSON.parse(@http_response.body)
    @array_workspace01 = []
    array_workspace_json.each do | workspace |
    var = DataHelper.rehash_to_symbol_keys(workspace)
    obj_workspace = Workspace.new(var)
    @array_workspace01.push(obj_workspace)
    end
end

When(/^I send a workspace (POST) with the json$/) do |method, json_text|
    @http_response, $workspace = WorkspaceRequest.create_ind_workspace(@client,method,json_text)
end

When(/^I send a workspace (PUT) request to add project$/) do |method|
    json_text = {:project_ids => [$project.id]}
    @http_response, $workspace = WorkspaceRequest.update_workspace(@client, method, $workspace.id, json_text.to_json)
end

When(/^I send a workspace (DELETE) request to delete WorkspaceRequest$/) do |method|
    @http_response, $workspace = WorkspaceRequest.delete_workspace(@client, method, $workspace.id)
end



# ACCEPTANCES
When(/^I send a workspace (POST) request with the json$/) do |method, json_text|
    @json_value = json_text
    @http_response, $workspace = WorkspaceRequest.create_workspace(@client, method, json_text)
    @json_response = JSON.parse(@http_response.body)
    WorkspaceRequest.delete_workspace(@client,"DELETE",$workspace.id)
end

# NEGATIVES
When(/^I send a workspace (GET) request for a workspace (.*?)$/) do |method, id_no_exist|
  @http_response, @WorkspaceError = WorkspaceRequest.get_workspace_by_id(@client, method, id_no_exist)

end



And(/^I expect the all inserted data workspace are the same$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.contain_same_value?(@json_value, @json_response)
  expect(result).to be true
end

And(/^I expect the kind of workspace is equal to (.*)$/) do |kind_workspace|
    result = false
    @json_value = JSON.parse(@json_value)
    expect(@json_response["kind"] == kind_workspace).to be true

end

And(/^I expect the all data type returned from workspace request are correct$/) do
    @string_name = @array_workspace01.map{|workspace| workspace.name }
    @integer_id = @array_workspace01.map{|workspace| workspace.id }
    @string_kind = @array_workspace01.map{|workspace| workspace.kind }

    expect(DataHelper.is_string_array?(@string_name)).to be true
    expect(DataHelper.is_integer_array?(@integer_id)).to be true
    expect(DataHelper.is_string_array?(@string_kind)).to be true

end



And(/^I expect an error message from workspace$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["error"]).to eql(@WorkspaceError.error.to_s)
end
# And(/^I expect the project error message (.*)$/) do |message|
#   expect(@ProjectError.error.to_s).to eql(message.to_s)
# end
# And(/^I expect the project error code (.*)$/) do |message|
#   expect(@ProjectError.code.to_s).to eql(message.to_s)
# end
# And(/^I expect the project error kind (.*)$/) do |message|
#   expect(@ProjectError.kind.to_s).to eql(message.to_s)
# end
# And(/^I expect the project error general problem (.*)$/) do |message|
#   expect(@ProjectError.general_problem.to_s).to eql(message.to_s)
# end
# And(/^I expect the project error possible fix (.*)$/) do |message|
#   expect(@ProjectError.possible_fix.to_s).to eql(message.to_s)
# end