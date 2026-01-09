# 🎯 Prometheus Certified Associate (PCA) - Study Guide

**Exam Code**: PCA  
**Duration**: 90 minutes  
**Questions**: 60 multiple choice  
**Passing Score**: 75%  
**Cost**: $250 USD  
**Estimated Study Time**: 50 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Observability Concepts | 18% | 9h | ⏳ |
| 2. Prometheus Fundamentals | 20% | 10h | ⏳ |
| 3. PromQL | 28% | 14h | ⏳ |
| 4. Instrumentation & Exporters | 16% | 8h | ⏳ |
| 5. Alerting & Dashboards | 18% | 9h | ⏳ |

---

## 📚 Domain 1: Observability Concepts (18%)

### The Four Golden Signals

```
1. Latency - How long does it take?
2. Traffic - How much demand?
3. Errors - What's failing?
4. Saturation - How full are resources?
```

### Metrics vs Logs vs Traces

```
Metrics (Prometheus):
  - Numerical measurements over time
  - Low cardinality
  - Example: http_requests_total{status="200"}

Logs:
  - Discrete events with context
  - High cardinality
  - Example: "2026-01-09 User john logged in"

Traces (Jaeger/Tempo):
  - Request flow across services
  - Distributed context
  - Example: API → Database → Cache → Response
```

---

## 📚 Domain 2: Prometheus Fundamentals (20%)

### Prometheus Architecture

```
┌─────────────┐
│ Prometheus  │
│   Server    │◄──── Pull metrics (HTTP)
└──────┬──────┘
       │
       ├──► Scrape Targets (exporters, apps)
       ├──► Local Storage (TSDB)
       ├──► Alertmanager
       └──► Visualization (Grafana)
```

### Metric Types

```yaml
# Counter (only increases)
http_requests_total 1234

# Gauge (can go up/down)
memory_usage_bytes 524288000

# Histogram (distribution)
http_request_duration_seconds_bucket{le="0.1"} 100
http_request_duration_seconds_bucket{le="0.5"} 250
http_request_duration_seconds_bucket{le="1.0"} 300

# Summary (similar to histogram, client-side)
http_request_duration_seconds{quantile="0.5"} 0.23
http_request_duration_seconds{quantile="0.9"} 0.87
```

### Configuration (prometheus.yml)

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'kubernetes-pods'
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
```

---

## 📚 Domain 3: PromQL (28%) ⭐ HIGHEST WEIGHT

### Basic Queries

```promql
# Instant vector (current value)
up

# Filter by label
up{job="prometheus"}

# Regex matching
http_requests_total{status=~"2.."}  # 2xx status codes

# Range vector (last 5 minutes)
http_requests_total[5m]
```

### Rate & Increase

```promql
# Rate (per-second average over 5min)
rate(http_requests_total[5m])

# Increase (total increase over 5min)
increase(http_requests_total[5m])

# irate (instant rate, last 2 samples)
irate(http_requests_total[5m])
```

### Aggregation Operators

```promql
# Sum across all instances
sum(http_requests_total)

# Sum by label
sum(http_requests_total) by (status)

# Average
avg(http_request_duration_seconds) by (endpoint)

# Max, min, count
max(node_memory_MemFree_bytes)
min(up)
count(up == 1)

# Quantile (95th percentile)
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))
```

### Advanced Queries

```promql
# Calculate error rate
sum(rate(http_requests_total{status=~"5.."}[5m])) 
  / 
sum(rate(http_requests_total[5m]))

# Memory usage percentage
(node_memory_MemTotal_bytes - node_memory_MemFree_bytes) 
  / node_memory_MemTotal_bytes * 100

# Absent (alert if metric missing)
absent(up{job="myapp"})

# Predict linear (forecast 1 hour ahead)
predict_linear(node_memory_MemFree_bytes[1h], 3600)
```

---

## 📚 Domain 4: Instrumentation & Exporters (16%)

### Go Application instrumentation

```go
package main

import (
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promauto"
    "github.com/prometheus/client_golang/prometheus/promhttp"
    "net/http"
)

var (
    httpRequestsTotal = promauto.NewCounterVec(
        prometheus.CounterOpts{
            Name: "http_requests_total",
            Help: "Total number of HTTP requests",
        },
        []string{"method", "endpoint", "status"},
    )
    
    httpRequestDuration = promauto.NewHistogramVec(
        prometheus.HistogramOpts{
            Name: "http_request_duration_seconds",
            Help: "HTTP request latency",
            Buckets: []float64{.005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10},
        },
        []string{"endpoint"},
    )
)

func main() {
    http.Handle("/metrics", promhttp.Handler())
    
    http.HandleFunc("/api/users", func(w http.ResponseWriter, r *http.Request) {
        timer := prometheus.NewTimer(httpRequestDuration.WithLabelValues("/api/users"))
        defer timer.ObserveDuration()
        
        // Handle request...
        
        httpRequestsTotal.WithLabelValues(r.Method, "/api/users", "200").Inc()
        w.Write([]byte("OK"))
    })
    
    http.ListenAndServe(":8080", nil)
}
```

### Common Exporters

```
Node Exporter:     OS metrics (CPU, memory, disk)
Blackbox Exporter: HTTP/DNS/TCP probing
MySQL Exporter:    MySQL database metrics
Redis Exporter:    Redis metrics
NGINX Exporter:    NGINX metrics
```

### Custom Exporter Pattern

```python
from prometheus_client import start_http_server, Gauge
import time

# Create metric
queue_size = Gauge('myapp_queue_size', 'Current queue size')

def collect_metrics():
    while True:
        # Get queue size from your application
        size = get_queue_size()
        queue_size.set(size)
        time.sleep(15)

if __name__ == '__main__':
    start_http_server(8000)  # Expose on :8000/metrics
    collect_metrics()
```

---

## 📚 Domain 5: Alerting & Dashboards (18%)

### Alert Rules

```yaml
groups:
  - name: example
    rules:
    - alert: HighErrorRate
      expr: |
        sum(rate(http_requests_total{status=~"5.."}[5m]))
          / 
        sum(rate(http_requests_total[5m])) > 0.05
      for: 10m
      labels:
        severity: critical
      annotations:
        summary: "High error rate detected"
        description: "Error rate is {{ $value | humanizePercentage }}"

    - alert: InstanceDown
      expr: up == 0
      for: 5m
      labels:
        severity: warning
      annotations:
        summary: "Instance {{ $labels.instance }} down"
```

### Alertmanager Configuration

```yaml
route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 12h
  receiver: 'default'
  
  routes:
  - match:
      severity: critical
    receiver: pagerduty
  
  - match:
      severity: warning
    receiver: slack

receivers:
- name: 'default'
  email_configs:
  - to: 'oncall@example.com'

- name: 'slack'
  slack_configs:
  - api_url: 'https://hooks.slack.com/services/...'
    channel: '#alerts'

- name: 'pagerduty'
  pagerduty_configs:
  - service_key: '<key>'
```

### Grafana Dashboard Query

```promql
# Panel 1: Request Rate
sum(rate(http_requests_total[5m])) by (status)

# Panel 2: Latency (95th percentile)
histogram_quantile(0.95, 
  sum(rate(http_request_duration_seconds_bucket[5m])) by (le, endpoint)
)

# Panel 3: Current Active Users
myapp_active_users

# Panel 4: Memory Usage
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Set Up Prometheus

- Install Prometheus
- Configure scrape targets
- Access web UI

### Lab 2: Node Exporter

- Deploy node exporter
- Scrape OS metrics
- Create CPU/Memory dashboards

### Lab 3: Instrument Application

- Add Prometheus client library
- Expose custom metrics
- Verify in Prometheus

### Lab 4: PromQL Mastery

- Write 20+ PromQL queries
- Calculate SLIs (error rate, latency)
- Practice aggregations

### Lab 5: Alerting

- Create alert rules
- Configure Alertmanager
- Test alert routing

### Lab 6: Grafana Integration

- Connect Prometheus datasource
- Build dashboards
- Set up alerts

---

## 📖 Study Schedule (50 Hours)

### Week 1 (15 hours)

- Domains 1-2: Observability, Prometheus fundamentals
- Complete Labs 1-2

### Week 2 (20 hours)

- Domain 3: PromQL (practice extensively!)
- Complete Labs 3-4

### Week 3 (15 hours)

- Domains 4-5: Exporters, Alerting, Dashboards
- Complete Labs 5-6
- Practice exam

---

## 📝 Practice Exam Questions

1. **Which function calculates per-second rate?**
   - a) increase()
   - b) rate() ✅
   - c) irate()
   - d) delta()

2. **Which metric type only increases?**
   - a) Gauge
   - b) Counter ✅
   - c) Histogram
   - d) Summary

3. **What's the default scrape interval?**
   - a) 5s
   - b) 15s ✅
   - c) 30s
   - d) 60s

---

## 🔗 Official Resources

- [PCA Exam Curriculum](https://training.linuxfoundation.org/certification/prometheus-certified-associate/)
- [Prometheus Docs](https://prometheus.io/docs/)
- [PromQL Tutorial](https://prometheus.io/docs/prometheus/latest/querying/basics/)

---

## ✅ Exam Preparation Checklist

- [ ] Installed and configured Prometheus
- [ ] Familiar with all 4 metric types
- [ ] Can write complex PromQL queries
- [ ] Created custom exporters
- [ ] Configured alerts and Alertmanager
- [ ] Built Grafana dashboards
- [ ] Practice exam score: 75%+

**Target Exam Date**: September 16, 2026  
**Study Period**: August 26 - September 16 (21 days)  
**🎉 FINAL CERTIFICATION!**
