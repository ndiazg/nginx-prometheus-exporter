# nginx-prometheus-exporter
Nginx metrics exporter for Prometheus.
Based on @ipfs mtail container, tails nginx logs and exports calculated metrics in Prometheus and json formats.
## Nginx Settings
Make sure your nginx logs follow this format:
```
log_format mtail '$host $remote_addr - $remote_user [$time_local] '
                 '"$request" $status $body_bytes_sent $request_time '
                 '"$http_referer" "$http_user_agent" "$content_type"';
```
In your server declaration block:
```
access_log /var/log/nginx/access.log mtail;
```
## Run
```
docker run -d \
  -v /var/log/nginx:/var/log/nginx:ro \
  -p 3093:3093 \
  ndiazg/nginx-prometheus-exporter \
  /var/log/nginx/access.log
```
## Scrape
Prometheus format
```
http://your-host:3093/metrics
```
Json format
```
http://your-host:3093/json
```
