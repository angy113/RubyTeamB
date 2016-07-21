require_relative '../../../src/requests/stories_get/stories_request'
require_relative '../../../src/helpers/data_helper'

When(/^I send story (GET) request to a project$/) do |method|
  #de donde sale y que hace @client???
  @http_response = StoriesRequest.get_stories(@client, method, $project.id)
end

When(/^I send stories (POST) with json$/) do |method, json_text|
  @http_response, $stories = StoriesRequest.create_stories(@client, method, $project.id, json_text)

end

When(/^I send a story (PUT) request to StoriesRequest with json$/) do |method, json_text|
  @http_response = StoriesRequest.update_story(@client, method, $project.id, json_text, $stories.id)
end

When(/^I send a story (DELETE) request to StoriesRequest$/) do |method|
  @http_response = StoriesRequest.delete_story(@client, method, $project.id, $stories.id)
end

#-----------------------------------

When(/^I send storiesAcceptance (POST) with json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @story = StoriesRequest.create_stories(@client, method, $project.id, json_text)
  @json_response = JSON.parse(@http_response.body)
end


And(/^I expect the data same of data send$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.contain_same_value?(@json_value, @json_response)
  expect(result).to be true

end


And(/^I expect the kind of story is equal to story$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.is_timestamp?(@json_response["created_at"]) && DataHelper.is_timestamp?(@json_response["updated_at"])
  expect(result).to be true

end
And(/^I expect the kind of story is equal to story (.*)$/) do |kind_story|
  result = false
  @json_value = JSON.parse(@json_value)
  expect(@json_response["kind"] == kind_story).to be true

end

And(/^I expect the project_id is the same that I have send$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  expect(@json_response["project_id"] == $project.id).to be true

end
When(/^I send storiesNegative (POST) with json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @error = StoriesRequest.create_stories(@client, method, $project.id, json_text)
  @json_response = JSON.parse(@http_response.body)

end
When(/^I send a NegativeStory (PUT) request to StoriesRequest with json$/) do |method, json_text|
  @http_response, @error = StoriesRequest.update_story(@client, method, $project.id, json_text, $stories.id)
end

And(/^I (DELETE) the recent story created$/)do|method|
  @http_response = StoriesRequest.delete_story(@client, method, $project.id, $stories.id)
  @idb=$stories.id
end

And(/^I (GET) try to call the recent story deleted$/)do|method|
  @http_response = StoriesRequest.get_stories(@client, method, @idb)
end

