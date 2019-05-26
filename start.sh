#!/bin/bash
docker-compose up -d
sleep 5
docker exec -it mongo mongo --eval 'rs.initiate()'
sleep 5
[ -e /home/joe40009/AIclothes_dockercompose/line_mysql/user_data ] || docker exec -itd mysql bash -c 'mysql -uroot -piii -e "CREATE SCHEMA user_data ;" &&  mysql -uroot -piii -e "CREATE TABLE user_data.line_user (  line_id VARCHAR(50) NOT NULL,  username VARCHAR(50) NOT NULL,  email VARCHAR(50) NULL,  cellphone VARCHAR(10) NULL,  sex VARCHAR(10) NOT NULL,  age VARCHAR(10) NULL,  height VARCHAR(10) NULL,  weight VARCHAR(10) NULL,  time DATETIME NULL,  PRIMARY KEY (line_id));"'
sh Activate3KafkaClusters.sh
sh Activate3HadoopClusters.sh
sh Activate3SparkClusters.sh
sleep 5
docker exec -itd master bash -c "cd /root/models ; spark-submit --master spark://master:7077 --executor-memory 3G --executor-cores 5 --driver-memory 3G --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.3.1 --files modules/clothes5_4310.h5 identify4spark.py"
