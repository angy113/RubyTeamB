require_relative '../../../src/requests/comments_get/comments_request'
require_relative '../../../src/requests/stories_get/stories_request'
require_relative '../../../src/helpers/data_helper'

When(/^I send a comments (GET) request for a project and stories comments$/) do |method|

  @http_response = CommentsRequest.get_comments(@client, method, $project.id, $story.id)
end

When(/^I send an comments (POST) with the json2$/) do |method, json_text|
  @http_response, $comments = CommentsRequest.create_comments(@client, method, $project.id, $story.id, json_text)
end

When(/^I send an comments (PUT) request to CommentsRequest with json$/) do |method, json_text|
  @http_response = CommentsRequest.update_comments(@client, method, $project.id, $story.id, $comments.id, json_text)
end

When(/^I send an comments (DELETE) request to CommentsRequest$/) do |method|
  @http_response = CommentsRequest.delete_comments(@client, method, $project.id, $story.id, $comments.id)

end


When(/^I send an Comments (POST) with the json$/) do |method, json_text|
  @json_value = json_text
  @http_response, @comments = CommentsRequest.create_comments(@client, method, $project.id, $story.id, json_text)
  @json_response = JSON.parse(@http_response.body)
end
And(/^I expect the all inserted data Comments are the same that the data sent$/) do
  result = false
  @json_value = JSON.parse(@json_value)
  result = DataHelper.contain_same_value?(@json_value, @json_response)
  expect(result).to be true
end

When(/^I send a Comments (GET) request for a project (.*?)$/) do |method, id_no_exist_proyect |
  @http_response = CommentsRequest.get_comments(@client, method, id_no_exist_proyect, $story.id)
end

When(/^I send a Comments (GET) request for a stories (.*?)$/) do |method, id_no_exist_stories |
  @http_response = CommentsRequest.get_comments(@client, method, $project.id, id_no_exist_stories)
end

When(/^I send a Comments (GET) request for a comments (.*?)$/) do |method, id_no_exist_comments |
  @http_response = CommentsRequest.get_comments_error(@client, method, $project.id, $story.id, id_no_exist_comments)
end


And(/^I expect an error message to Comments$/) do
  @json_response = JSON.parse(@http_response.body)
  expect(@json_response["error"]).to eql(Comments::ERROR[:error_message])
end
