require 'json/ext'
require_relative '../../../src/helpers/rest_client/api_rest_client'
require_relative '../../../src/data/me_details'
require_relative '../../../src/requests/project_request/project_request'

Given(/^I have set a connection to pivotal_tracker API service$/) do
  @client = ApiRestClient.new
  @http_connection =@client.get_connection
end

Then(/^I expect Status code (\d+)$/) do |http_code|
  expect(@http_response.code.to_s).to eql(http_code.to_s)
end
