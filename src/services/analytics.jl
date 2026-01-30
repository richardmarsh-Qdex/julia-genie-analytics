module Analytics

using DataFrames, Statistics, CSV
using Dates: now

function generate_dashboard_data()
  metrics = Metrics.get_all_metrics()
  
  if isempty(metrics)
    return Dict(
      "total_metrics" => 0,
      "average_value" => 0.0,
      "categories" => Dict(),
      "recent_metrics" => []
    )
  end
  
  df = DataFrame(metrics)
  
  categories = Dict()
  for cat in unique(df.category)
    categories[cat] = count(r -> r.category == cat, eachrow(df))
  end
  
  return Dict(
    "total_metrics" => nrow(df),
    "average_value" => mean(df.value),
    "max_value" => maximum(df.value),
    "min_value" => minimum(df.value),
    "categories" => categories,
    "recent_metrics" => last(df, 10) |> eachrow .|> Dict
  )
end

function generate_report(params)
  start_date = get(params, "start_date", nothing)
  end_date = get(params, "end_date", nothing)
  category = get(params, "category", nothing)
  
  metrics = Metrics.get_all_metrics()
  df = DataFrame(metrics)
  
  if category !== nothing
    df = filter(r -> r.category == category, df)
  end
  
  return Dict(
    "total_records" => nrow(df),
    "statistics" => Dict(
      "mean" => mean(df.value),
      "median" => median(df.value),
      "std" => std(df.value),
      "min" => minimum(df.value),
      "max" => maximum(df.value)
    ),
    "data" => [Dict(row) for row in eachrow(df)]
  )
end

end
