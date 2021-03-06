# -*- mode: ruby -*-
# vi: set ft=ruby :

$esVersion = "5.0.2"    # ElasticSearch & Kibana version
$esRPort = 9200         # ElasticSearch Http Rest API port
$esTPort = 9300         # ElasticSearch Transport port
$kibanaPort = 5601
$searchGuardVersion = "#{$esVersion}-9"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  config.vm.network :forwarded_port, guest: $esRPort, host: $esRPort
  config.vm.network :forwarded_port, guest: $esTPort, host: $esTPort
  config.vm.network :forwarded_port, guest: $kibanaPort, host: $kibanaPort

  config.vm.synced_folder "data", "/vagrant/data", :mount_options => ['dmode=777','fmode=666']

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end

  config.vm.provision "shell", inline: <<-SHELL
    sed -i "1s/.*/FROM elasticsearch:#{$esVersion}/" /vagrant/elasticsearch/Dockerfile
    sed -i "2s/.*/RUN elasticsearch-plugin install -b com.floragunn:search-guard-5:#{$searchGuardVersion}/" /vagrant/elasticsearch/Dockerfile
    sed -i "1s/.*/FROM kibana:#{$esVersion}/" /vagrant/kibana/Dockerfile
  SHELL

  if $esVersion == '5.0.2' || $esVersion == '5.1.1' || $esVersion == '5.1.2'
      config.vm.provision "shell", inline: <<-SHELL
        sed -i "2s@.*@RUN kibana-plugin install https://github.com/floragunncom/search-guard-kibana-plugin/releases/download/v#{$esVersion}-alpha/searchguard-kibana-alpha-#{$esVersion}.zip@" /vagrant/kibana/Dockerfile
        sed -i '1s/.*/searchguard.cookie.password: "Xae8eephaicoe8eh8Daesee2aemingbh"/' /vagrant/kibana/config/kibana.yml
      SHELL
  else
      config.vm.provision "shell", inline: <<-SHELL
        sed -i "2s@.*@@" /vagrant/kibana/Dockerfile
        sed -i '1s/.*//' /vagrant/kibana/config/kibana.yml
      SHELL
  end

  config.vm.provision "docker" do |d|
    d.build_image "/vagrant/elasticsearch", args: "-t es_sg"
    d.build_image "/vagrant/kibana", args: "-t kibana_sg"
  end

  config.vm.provision "shell", path: "run_es.sh", args: [ $esRPort, $esTPort ]
  config.vm.provision "shell", path: "run_kibana.sh", args: [ $kibanaPort ]

  config.vm.provision "shell", path: "load_sg_config.sh"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
