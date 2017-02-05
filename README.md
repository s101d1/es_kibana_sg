Vagrant script for providing development environment of ElasticSearch + Kibana Docker with SearchGuard plugin installed. Both ElasticSearch and Kibana will run with default ports exposed.

The `data` folder will contain the ElasticSearch data.

The `certs` folder contains the self-signed ssl certificate files.

Configs
---
The application configuration files are all in `elasticsearch/config` and `kibana/config` folder respectively.

SearchGuard configuration files are in `elasticsearch/config/sgconfig`.

Scripts
---
`/vagrant/run_es.sh` is bash script for restarting ElasticSearch docker.

`/vagrant/run_kibana.sh` is bash script for restarting Kibana docker.

`/vagrant/load_sg_config.sh` is bash script for loading SearchGuard configs.

You can run the scripts inside the machine via `vagrant ssh`.
