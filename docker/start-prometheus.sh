#!/bin/bash

docker run -d \
--name prometheus \
-p 80:9090 \
-v /etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
prom/prometheus:v2.52.0
