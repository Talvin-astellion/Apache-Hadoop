cd '/docker'
docker-compose build jupyterlab

docker-compose up -d spark-master spark-worker-1 spark-worker-2 jupyterlab

docker exec -it jupyterlab bash -c "python -c 'import pyspark, sys; print(\"pyspark\", pyspark.__version__); import py4j; print(\"py4j\", py4j.__version__)'"

If you want to run the full stack:
docker-compose up --build