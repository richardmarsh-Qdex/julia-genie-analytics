module Helpers

using Dates

function validate_metric_data(data)
  required_fields = ["name", "value"]
  for field in required_fields
    if !haskey(data, field)
      return false, "Missing required field: $field"
    end
  end
  
  if !isa(data["value"], Number)
    return false, "Value must be a number"
  end
  
  return true, ""
end

function format_timestamp(dt)
  return string(dt)
end

end
