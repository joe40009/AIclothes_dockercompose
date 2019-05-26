#!/bin/bash
docker-compose down
docker run --name mongo -d -v ./line_mongodb:/data/db mongo mongod
sleep 2
docker exec -it mongo mongo local --eval 'db.system.replset.remove({})'
docker rm -f mongo
