require_relative '../../../src/requests/project_request/project_request'
require_relative '../../../src/helpers/data_helper'

When(/^I send a project (GET) request$/) do |method|
  @http_response = ProjectRequest.get_projects(@client, method)
  array_project_json = JSON.parse(@http_response.body)
  @array_project1 = []
  array_project_json.each do |project|
    var = DataHelper.rehash_to_symbol_keys(project)
    obj_project = Project.new(var)
    @array_project1.push(obj_project)
  end
end

When(/^I send a project (POST) with the json2$/) do |method, json_text|
  @http_response, $projects = ProjectRequest.create_project(@client, method, json_text)
end

When(/^I send a project (PUT) request to ProjectRequest with json$/) do |method, json_text|
  @http_response, $projects = ProjectRequest.update_project(@client, method, $projects.id, json_text)
end

When(/^I send a project (DELETE) request to ProjectRequest$/) do |method|
  @http_response, _= ProjectRequest.delete_project(@client, method, $projects.id)

end

When(/^I send a project (POST) with the json$/) do |method, json_text|
  @json_value = json_text

  @http_response, $projects = ProjectRequest.create_project(@client, method, json_text)

  @json_response = JSON.parse(@http_response.body)
  ProjectRequest.delete_project(@client, "DELETE", $projects.id)
end

When(/^I send a project negative (POST) with the json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @ProjectError = ProjectRequest.create_project(@client, method, json_text)
  @json_response = JSON.parse(@http_response.body)
end

When(/^I send a project negative (PUT) with the json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @ProjectError = ProjectRequest.update_project(@client, method, $project.id, json_text)
  @json_response = JSON.parse(@http_response.body)
end
When(/^I send a project negative (PUT) with (.*?) project id and with the json$/) do |method, invalid_id, json_text|
  @json_value = json_text
  @http_response, @ProjectError = ProjectRequest.update_project(@client, method, invalid_id, json_text)
  @json_response = JSON.parse(@http_response.body)
end
When(/^I send a project (DELETE) request with the wrong project id (.*?)$/) do |method, wrong_id|
  @http_response, @ProjectError = ProjectRequest.delete_project(@client, method, wrong_id)

end
And(/^I expect the all inserted data are the same$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.contain_same_value?(@json_value, @json_response)
  expect(result).to be true

end

And(/^I expect all data correct$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.contain_same_value?(@json_value, @json_response)
  expect(result).to be true
end

And(/^I expect the date format is correct$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.is_timestamp?(@json_response["created_at"]) && DataHelper.is_timestamp?(@json_response["updated_at"])
  expect(result).to be true
end

And(/^I expect the kind of project is equal to (.*)$/) do |kind_project|
  result = false
  @json_value = JSON.parse(@json_value)
  expect(@json_response["kind"] == kind_project).to be true

end
And(/^I expect the project_id is the same$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  expect(@json_response["id"] == $projects.id).to be true

end

And(/^I expect the all data type returned from project request are correct$/) do
  @array_string_name = @array_project1.map { |project| project.name }
  @array_integer_id = @array_project1.map { |project| project.id }
  @array_string_kind = @array_project1.map { |project| project.kind }

  expect(DataHelper.is_string_array?(@array_string_name)).to be true
  expect(DataHelper.is_integer_array?(@array_integer_id)).to be true
  expect(DataHelper.is_string_array?(@array_string_kind)).to be true

end
When(/^I send a project (GET) request for a project (.*?)$/) do |method, id_no_exist|
  @http_response, @ProjectError = ProjectRequest.get_project_by_id(@client, method, id_no_exist)

end

And(/^I expect an error message from project$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["error"]).to eql(@ProjectError.error.to_s)
end
And(/^I expect the project error message (.*)$/) do |message|
  expect(@ProjectError.error.to_s).to eql(message.to_s)
end
And(/^I expect the project error code (.*)$/) do |message|
  expect(@ProjectError.code.to_s).to eql(message.to_s)
end
And(/^I expect the project error kind (.*)$/) do |message|
  expect(@ProjectError.kind.to_s).to eql(message.to_s)
end
And(/^I expect the project error general problem (.*)$/) do |message|
  expect(@ProjectError.general_problem.to_s).to eql(message.to_s)
end
And(/^I expect the project error possible fix (.*)$/) do |message|
  expect(@ProjectError.possible_fix.to_s).to eql(message.to_s)
end

