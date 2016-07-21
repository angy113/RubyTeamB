require_relative '../../../src/data/workspace'
require_relative '../../../src/data/error'

class WorkspaceRequest

  def self.create_workspace(client, method, json)#POST
    end_point = '/my/workspaces'
    http_request = client.get_request(method, end_point)
    http_request.body = json

    http_response = client.execute_request(client.get_connection, http_request)
    obj_workspace = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_workspace)
    if http_response.code.to_s=="200"
      obj_workspace = Workspace.new(var)
    else
      obj_workspace = Error.new(var)
    end

    return http_response, obj_workspace
  end


  def self.get_workspace(client, method) #GET
    end_point = '/my/workspaces'
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    http_response
  end

  def self.create_ind_workspace(client, method, json)#POST
    end_point = '/my/workspaces/'
    http_request = client.get_request(method, end_point)
    http_request.body = json
    http_response = client.execute_request(client.get_connection, http_request)
    @obj_workspace = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(@obj_workspace)
    @obj_workspace = Workspace.new(var)
    p "from create method #{http_response}"
    return http_response, @obj_workspace
  end

  def self.update_workspace(client, method, id_workspace, json_text) #PUT
    end_point = '/my/workspaces/%s' %id_workspace
    http_request = client.get_request(method, end_point)
    http_request.body = json_text
    http_response = client.execute_request(client.get_connection, http_request)

    obj_workspace = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_workspace)
    if http_response.code.to_s=="200"
      obj_workspace = Workspace.new(var)
    else
      obj_workspace = Error.new(var)
    end

    return http_response, obj_workspace
  end

  def self.get_workspace_by_id(client, method, id_workspace)#GET
    end_point = '/my/workspaces/%s' %id_workspace
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)
    obj_workspace = JSON.parse(http_response.body)
    var = DataHelper.rehash_to_symbol_keys(obj_workspace)
    if http_response.code.to_s=="200"
      obj_workspace = Workspace.new(var)
    else
      obj_workspace = Error.new(var)
    end

    return http_response, obj_workspace
  end

  def self.delete_workspace(client, method, id_workspace)
    end_point = '/my/workspaces/%s' %id_workspace
    http_request = client.get_request(method, end_point)
    http_response = client.execute_request(client.get_connection, http_request)

    obj_workspace = nil
    if http_response.body != nil
      obj_workspace = JSON.parse(http_response.body)
      var = DataHelper.rehash_to_symbol_keys(obj_workspace)
      obj_workspace = Error.new(var)
    end
  return http_response, obj_workspace
  end

end