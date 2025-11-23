cd '/docker'
docker-compose build jupyterlab

docker-compose up -d spark-master spark-worker-1 spark-worker-2 jupyterlab

docker exec -it jupyterlab bash -c "python -c 'import pyspark, sys; print(\"pyspark\", pyspark.__version__); import py4j; print(\"py4j\", py4j.__version__)'"

If you want to run the full stack:
docker-compose up --build

Upgrade Cluster. Use instruments:
PARK_VERSION: "3.5.0"
HADOOP_VERSION: "3.3"
HIVE_VERSION = 3.1.3
POSTGRES_VERSION = 12
Java >= 11 
jupyterlab >= 3.5
jupyter notebook >= 6.5
Python 3.8 – 3.12

See Jyputer notebook in:
http://localhost:8889/

Your pyspark code.
- Go to Hue using the url: http://localhost:8888/, and check your tables in HDFS
