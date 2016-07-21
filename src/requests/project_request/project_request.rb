require_relative '../../../src/data/project'
require_relative '../../../src/data/error'
class ProjectRequest

  def self.create_project(client, method, json) #POST
    end_point = '/projects'
    http_request = client.get_request(method, end_point)
    http_request.body = json

    http_response = client.execute_request(client.get_connection, http_request)
    obj_response = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_response)
    if http_response.code.to_s=="200"
      obj_response = Project.new(var)
    else
      obj_response = Error.new(var)
    end

    return http_response, obj_response

  end


  def self.delete_project(client, method, id_project) #DELETE
    end_point = '/projects/%s' %id_project
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)

    obj_response = nil
    if http_response.body != nil
      obj_response = JSON.parse(http_response.body)
      var = DataHelper.rehash_to_symbol_keys(obj_response)
      obj_response = Error.new(var)
    end

    return http_response, obj_response
  end

  def self.get_projects(client, method) #GET
    end_point = '/projects/'
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.get_project_by_id(client, method, id_project) #GET
    end_point = '/projects/%s/' %id_project
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)

    obj_response = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_response)
    if http_response.code.to_s=="200"
      obj_response = Project.new(var)
    else
      obj_response = Error.new(var)
    end

    return http_response, obj_response

  end

  def self.update_project(client, method, id_project, json_text) #POST
    end_point = '/projects/%s' %id_project
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)

    obj_response = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_response)
    if http_response.code.to_s=="200"
      obj_response = Project.new(var)
    else
      obj_response = Error.new(var)
    end

    return http_response, obj_response
  end

end