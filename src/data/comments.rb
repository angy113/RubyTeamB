require_relative 'base_class_for_data_classes'

class Comments < BaseClassForDataClasses
  attr_accessor :kind,
                :id,
                :story_id,
                :text,
                :person_id,
                :created_at,
                :updated_at
  ERROR = {:error_message => "The object you tried to access could not be found.  It may have been removed by another user, you may be using the ID of another object type, or you may be trying to access a sub-resource at the wrong point in a tree."}

  def initialize(values = {})
    super(values)
  end

end
