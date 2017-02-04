#!/usr/bin/env bash

sleep 5

for i in `seq 1 60`;
do
	docker exec elasticsearch /usr/share/elasticsearch/plugins/search-guard-5/tools/sgadmin.sh -cd /usr/share/elasticsearch/config/sgconfig -ks /usr/share/elasticsearch/config/certs/admin-keystore.jks -ts /usr/share/elasticsearch/config/certs/truststore.jks -kspass changeit -tspass changeit -icl -nhnv

    if [ $? -eq 0 ]; then
        break
    else
        echo "Trying to connect to localhost:9300...($i)"
        sleep 1
    fi
done
