#!/bin/bash
docker-compose down
sleep 3
docker run --name mongo -d -v $(pwd)/line_mongodb:/data/db mongo mongod
sleep 5
docker exec -it mongo mongo local --eval 'db.system.replset.remove({})'
docker rm -f mongo
