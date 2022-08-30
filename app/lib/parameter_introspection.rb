# frozen_string_literal: true

# Determine class and record from a parameter hash
class ParameterIntrospection
  attr_reader :parameters

  def initialize(parameters:)
    @parameters = parameters
  end

  def id_param
    parameters.each_key.find { |key| /_id$/.match(key) }
  end

  def id_param_class
    id_param.gsub('_id', '').classify.safe_constantize
  end

  def id_param_instance
    id_param_class.find_by(id: parameters[id_param])
  end
end
