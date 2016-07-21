require_relative '../../../src/requests/epic_get/epic_request'
require_relative '../../../src/helpers/data_helper'

When(/^I send a epic (GET) request for a project$/) do |method|
  @http_response = EpicRequest.get_epics(@client, method, $project.id)
  array_epic_json = JSON.parse(@http_response.body)
  @array_epic1 = []
  array_epic_json.each do | epic |
    var = DataHelper.rehash_to_symbol_keys(epic)
    obj_epic = Epic.new(var)
    @array_epic1.push(obj_epic)
  end

end
When(/^I send an epic (POST) with the json$/) do |method, json_text|
  @http_response, $epic = EpicRequest.create_epic(@client, method, $project.id, json_text)

end

When(/^I send an epic (PUT) request to EpicRequest with json$/) do |method, json_text|
  @http_response = EpicRequest.update_epic(@client, method, $project.id, json_text, $epic.id)

end

When(/^I send an epic (DELETE) request to EpicRequest$/) do |method|
   @http_response = EpicRequest.delete_epic(@client, method, $project.id, $epic.id)

end

When(/^I send an epic (POST) request with the json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @epic = EpicRequest.create_epic(@client, method, $project.id, json_text)
  @json_response = JSON.parse(@http_response.body)
end

And(/^I expect the all inserted data are the same that the data sent$/) do
    result = false
    @json_value = JSON.parse(@json_value)
    result = DataHelper.contain_same_value?(@json_value, @json_response)
    expect(result).to be true

end
And(/^I expect the all date format are correct$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.is_timestamp?(@json_response["created_at"]) && DataHelper.is_timestamp?(@json_response["updated_at"])
  expect(result).to be true

end

And(/^I expect the kind of epic is equal to (.*)$/) do |kind_epic|
  @json_value = JSON.parse(@json_value)
  expect(@json_response["kind"] == kind_epic).to be true

end
And(/^I expect the project_id is the same that I have sent$/) do
  @json_value = JSON.parse(@json_value)
  expect(@json_response["project_id"] == $project.id).to be true

end
And(/^I send a (GET) request for the deleted epic$/) do |method|
  @http_response = EpicRequest.get_epic_by_id(@client,method,$project.id,$epic.id)

end

And(/^I expect the all data type returned from epic request are correct$/) do
  @array_string_name = @array_epic1.map{|epic| epic.name }
  @array_integer_id = @array_epic1.map{|epic| epic.id }
  @array_string_kind = @array_epic1.map{|epic| epic.kind }

  expect(DataHelper.is_string_array?(@array_string_name)).to be true
  expect(DataHelper.is_integer_array?(@array_integer_id)).to be true
  expect(DataHelper.is_string_array?(@array_string_kind)).to be true

end
When(/^I send a epic (GET) request for a project (.*?)$/) do |method, id_no_exist|
  @http_response, $epic = EpicRequest.get_epics(@client, method, id_no_exist)

end

And(/^I expect an error message to epic$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["error"]).to eql(Epic::ERROR[:error_message])
end

When(/^I send an epic (POST) request with invalid data with the json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @error = EpicRequest.create_epic(@client, method, $project.id, json_text)
  @json_response = JSON.parse(@http_response.body)
end

And(/^I expect an error message to invalid data epic$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["code"]).to eql(@error.code)

end

And(/^I expect an error message to empty data epic$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["code"]).to eql(Epic::ERROR[:code_invalid_parameter])
end

# And(/^The epic should not be in the project anymore$/)do
#   @json_response = JSON.parser(@http_response.body)
#   expect(@json_response["code"]).to be eql(Epic::ERROR[:code])
#   expect(@json_response["kind"]).to be eql(Epic::ERROR[:kind])
#   expect(@json_response["error"]).to be eql(Epic::ERROR[:error_message])
# end
When(/^I send an epic (PUT) request with invalid id (.*?)$/) do |method,epic_id ,json_text|
  @http_response = EpicRequest.update_epic(@client, method, $project.id, json_text, epic_id)

end
And(/^I expect and error message for invalid id$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["code"]).to eql(Epic::ERROR[:code])
end








