require_relative '../../../src/data/epic'
require_relative '../../helpers/data_helper'
class EpicRequest

  def self.get_epics(client, method, id_project)#GET
    end_point = '/projects/%s/epics/' % id_project
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end
  def self.get_epic_by_id(client, method, id_project, id_epic)#GET
    end_point = '/projects/%s/epics/%s' % [id_project, id_epic]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.delete_epic(client, method, id_project, id_epic) #DELETE
    end_point = '/projects/%s/epics/%s' % [id_project, id_epic]
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.create_epic(client, method, id_project, json_text) #POST
    end_point = '/projects/%s/epics' % id_project
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)
    if(http_response.code.to_s == "200")
      obj_epic = JSON.parse(http_response.body)
      var = DataHelper.rehash_to_symbol_keys(obj_epic)
      obj_epic = Epic.new(var)
      return http_response, obj_epic
    else
      obj_error = JSON.parse(http_response.body)
      var = DataHelper.rehash_to_symbol_keys(obj_error)
      obj_error = Error.new(var)
      return http_response, obj_error
    end

  end

  def self.update_epic(client, method, id_project, json_text, id_epic) #POST
    end_point = '/projects/%s/epics/%s' % [id_project, id_epic]
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

end