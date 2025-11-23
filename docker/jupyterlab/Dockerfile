FROM jupyter/base-notebook:latest

# Install PySpark 3.5.0
USER root
RUN pip install --no-cache-dir pyspark==3.5.0
ENV PYSPARK_PYTHON=python3

USER ${NB_UID}

# Expose Spark UI default port (container will still use notebook entrypoint)
EXPOSE 4040
