FROM eclipse-temurin:11-jre

ARG SPARK_VERSION=3.5.0
ARG HADOOP_VERSION=3.3
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    net-tools \
    procps \
  && rm -rf /var/lib/apt/lists/*

# Download Spark binary (hadoop 3.3 build) and extract
RUN set -eux \
  && PRIMARY_URL="https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz" \
  && ARCHIVE_URL="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz" \
  && echo "Attempting to download Spark from $PRIMARY_URL (fallback: $ARCHIVE_URL)" \
  && for url in "$PRIMARY_URL" "$ARCHIVE_URL"; do \
       if curl -fSL "$url" -o /tmp/spark.tgz; then \
         echo "Downloaded Spark from $url"; break; \
       else \
         echo "Failed to download from $url"; \
       fi; \
     done; \
  test -s /tmp/spark.tgz; \
  mkdir -p ${SPARK_HOME} \
  && tar -xzf /tmp/spark.tgz -C /opt \
  && mv /opt/spark-${SPARK_VERSION}-bin-hadoop3 ${SPARK_HOME} \
  && rm /tmp/spark.tgz

# Install pyspark for local use inside containers (optional)
RUN pip3 install --no-cache-dir --break-system-packages pyspark==3.5.0

WORKDIR ${SPARK_HOME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080 7077 8081 4040

ENTRYPOINT ["/entrypoint.sh"]
