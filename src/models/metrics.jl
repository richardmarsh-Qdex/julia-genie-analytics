module Metrics

using DataFrames, CSV, JSON

const METRICS_FILE = "data/metrics.csv"

function init_metrics()
  if !isfile(METRICS_FILE)
    df = DataFrame(
      id = Int[],
      name = String[],
      value = Float64[],
      category = String[],
      timestamp = String[]
    )
    CSV.write(METRICS_FILE, df)
  end
end

function get_all_metrics()
  if isfile(METRICS_FILE)
    df = CSV.read(METRICS_FILE, DataFrame)
    return [Dict(row) for row in eachrow(df)]
  end
  return []
end

function get_metric_by_id(id)
  if isfile(METRICS_FILE)
    df = CSV.read(METRICS_FILE, DataFrame)
    row = filter(r -> r.id == id, df)
    if nrow(row) > 0
      return Dict(first(eachrow(row)))
    end
  end
  return nothing
end

function create_metric(metric_data)
  if !isfile(METRICS_FILE)
    init_metrics()
  end
  
  df = CSV.read(METRICS_FILE, DataFrame)
  new_id = isempty(df) ? 1 : maximum(df.id) + 1
  
  new_row = DataFrame(
    id = [new_id],
    name = [metric_data["name"]],
    value = [metric_data["value"]],
    category = [get(metric_data, "category", "general")],
    timestamp = [string(now())]
  )
  
  append!(df, new_row)
  CSV.write(METRICS_FILE, df)
  
  return new_id
end

end
