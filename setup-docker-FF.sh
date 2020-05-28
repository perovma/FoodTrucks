#!/bin/bash

# build the flask container
docker build -t northernmerlin/foodtrucks-web .
# create the network
docker network create foodtrucks

#On the host OS
#sudo sysctl -w vm.max_map_count=262144

# start the ES container
docker run -d -p 9200:9200 -p 9300:9300 --net foodtrucks --name es -e "discovery.type=single-node" elasticsearch:7.7.0
# start the flask app container
docker run -d --net foodtrucks -p 5000:5000 --name foodtrucks-web northernmerlin/foodtrucks-web
