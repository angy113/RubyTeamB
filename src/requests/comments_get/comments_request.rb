require_relative '../../../src/data/comments'
require_relative '../../helpers/data_helper'
class CommentsRequest
  def self.get_comments(client, method, id_project,id_stories)#GET
    end_point = '/projects/%s/stories/%s/comments/' % [id_project,id_stories]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.get_comments_error(client, method, id_project, id_stories, id_comments)#GET
    end_point = '/projects/%s/stories/%s/comments/%s' % [id_project,id_stories,id_comments]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.get_comments_by_id(client, method, id_project, id_epic)#GET
    end_point = '/projects/%s/epics/%s' % [id_project, id_epic]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    obj_comments = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_comments)
    obj_comments = Comments.new(var)
    return http_response, obj_comments
  end

  def self.delete_comments(client, method, id_project, id_stories, id_comments) #DELETE
    end_point = '/projects/%s/stories/%s/comments/%' % [id_project,id_stories,id_comments]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.create_comments(client, method, id_project,id_stories, json_text) #POST
    end_point = '/projects/%s/stories/%s/comments/' % [id_project,id_stories]
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)
    obj_comments = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_comments)
    obj_comments = Comments.new(var)
    return http_response, obj_comments
  end

  def self.update_comments(client, method, id_project, id_stories, id_comments,json_text) #PUT
    end_point = '/projects/%s/stories/%s/comments/%s' % [id_project,id_stories,id_comments]
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.delete_comments(client, method, id_project, id_stories, id_comments) #DELETE
    end_point = '/projects/%s/stories/%s/comments/%s' % [id_project,id_stories,id_comments]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

end