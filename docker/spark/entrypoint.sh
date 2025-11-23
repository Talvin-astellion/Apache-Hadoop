#!/bin/bash
set -e

# Simple entrypoint: if SPARK_ROLE=master start master, if worker start worker and connect to SPARK_MASTER
if [ "$SPARK_ROLE" = "master" ] || [ "$1" = "master" ]; then
  echo "Starting Spark master..."
  ${SPARK_HOME}/sbin/start-master.sh
  tail -f ${SPARK_HOME}/logs/* || sleep infinity
elif [ "$SPARK_ROLE" = "worker" ] || [ "$1" = "worker" ]; then
  if [ -z "$SPARK_MASTER_URL" ]; then
    echo "SPARK_MASTER_URL not set; expected e.g. spark://spark-master:7077"
    exit 1
  fi
  echo "Starting Spark worker connecting to ${SPARK_MASTER_URL}..."
  ${SPARK_HOME}/sbin/start-worker.sh ${SPARK_MASTER_URL}
  tail -f ${SPARK_HOME}/logs/* || sleep infinity
else
  # fallback: run provided command
  exec "$@"
fi
