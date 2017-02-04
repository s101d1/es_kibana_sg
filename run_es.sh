#!/usr/bin/env bash

sudo sysctl -w vm.max_map_count=262144

docker stop elasticsearch
docker rm elasticsearch

docker run -e ES_JAVA_OPTS='-Xms1g -Xmx1g' --name elasticsearch -v /vagrant/elasticsearch/config:/usr/share/elasticsearch/config -v /vagrant/certs:/usr/share/elasticsearch/config/certs -v /vagrant/data:/usr/share/elasticsearch/data -p $1:$1 -p $2:$2 -d es_sg
