require_relative 'base_class_for_data_classes'

class Error < BaseClassForDataClasses
  attr_accessor :code,
                :kind,
                :error,
                :general_problem,
                :requirement,
                :validation_errors,
                :possible_fix

  def initialize(values = {})
    super(values)
  end
end