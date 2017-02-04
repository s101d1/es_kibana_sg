#!/usr/bin/env bash

docker stop kibana
docker rm kibana

docker run --link elasticsearch --name kibana -v /vagrant/kibana/config/kibana.yml:/etc/kibana/kibana.yml -v /vagrant/certs/root-ca.pem:/etc/certs/root-ca.pem -p $1:$1 -d kibana_sg
