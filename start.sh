#!/bin/bash
docker-compose up -d
docker exec -d mongo mongo --eval "rs.initiate()"
sh Activate3KafkaClusters.sh
sh Activate3HadoopClusters.sh
sh Activate3SparkClusters.sh
docker exec -itd master bash -c "cd /root/models ; spark-submit --master spark://master:7077 --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.3.1 --files modules/clothes5_4310.h5 identify4spark.py"
