require_relative 'base_class_for_data_classes'

class Epic < BaseClassForDataClasses
  attr_accessor :id,
                :kind,
                :created_at,
                :updated_at,
                :project_id,
                :name,
                :url,
                :label
  ERROR = {:error_message => "The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree.",
           :error => "unfound_resource",
           :kind => "error",
           :code => "could_not_parse_body",
           :code_invalid_parameter => "invalid_parameter"
  }
  def initialize(values = {})
    super(values)
  end

end