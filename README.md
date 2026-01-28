# Data Analytics Platform - Julia + Genie

A data analytics and metrics platform built with Julia and Genie framework.

## Features

- Metric collection and storage
- Real-time analytics dashboard
- Custom report generation
- Statistical analysis
- RESTful API endpoints

## Installation

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

## Configuration

Create `data/` directory for storing metrics:

```bash
mkdir -p data
```

## Running

```bash
julia --project=. app.jl
```

## API Endpoints

- GET /api/metrics - Get all metrics
- POST /api/metrics - Create metric
- GET /api/metrics/:id - Get metric by ID
- GET /api/analytics/dashboard - Get dashboard data
- POST /api/analytics/report - Generate custom report

## Tech Stack

- Julia
- Genie Framework
- DataFrames
- CSV
- Statistics
