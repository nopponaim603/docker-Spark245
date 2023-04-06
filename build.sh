SPARK_VERSION="3.3.2"
HADOOP_VERSION="3.3"
JUPYTERLAB_VERSION="3.6.3"

# -- Building the Images

docker build \
  -f cluster-base.Dockerfile \
  -t nopponaim603/debian-cluster-base .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile \
  -t nopponaim603/spark-base:3.3.2 .

docker build \
  -f spark-master.Dockerfile \
  -t nopponaim603/spark-master:3.3.2 .

docker build \
  -f spark-worker.Dockerfile \
  -t nopponaim603/spark-worker:3.3.2 .

docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t nopponaim603/jupyterlab:3.6.3 .

# Local copy of Notebooks and job-submit scripts outside Git change tracking
mkdir -p ./local/notebooks
cp -R ./notebooks/* ./local/notebooks

