using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json

route("/") do
  json(Dict("message" => "Data Analytics Platform API"))
end

route("/api/metrics", method=GET) do
  metrics = get_all_metrics()
  json(Dict("metrics" => metrics))
end

route("/api/metrics", method=POST) do
  metric_data = jsonpayload()
  metric_id = create_metric(metric_data)
  json(Dict("id" => metric_id, "message" => "Metric created"))
end

route("/api/metrics/:id", method=GET) do
  metric = get_metric_by_id(payload(:id))
  if metric !== nothing
    json(metric)
  else
    Genie.Renderer.respond(404, Dict("error" => "Metric not found"))
  end
end

route("/api/analytics/dashboard", method=GET) do
  dashboard_data = generate_dashboard_data()
  json(dashboard_data)
end

route("/api/analytics/report", method=POST) do
  report_params = jsonpayload()
  report = generate_report(report_params)
  json(report)
end

up(3000, async=false)
