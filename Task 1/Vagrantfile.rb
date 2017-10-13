Vagrant.require_version ">= 1.8.0"

environment_name = "CentOs7+Docker test"
memsize = 2048
numvcpus = 2

Vagrant.configure("2") do | config |

  # Box, we are getting this from vagrant cloud
  config.vm.box = "centos/7"
  #incase if we don't want to get it from vagrant cloud or we need a custom box then we can give the custom url
  #config.vm.box_url = "file://./anutosh/builds/centos7-x64-virtualbox.box"
  config.vm.boot_timeout = 120 #this can be changes as per situation.

  # Check for vbguest plugin for installing guest addition
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.no_remote = false
  end

  # Synced folders, feel free to remove this part if you are not working on this sort of project or not needed
    config.vm.synced_folder "/home/anutosh/src", "./anutosh/my_project/vagrant", type: "nfs"
  end

  # Oracle VirtualBox
  config.vm.provider :virtualbox do | vb |
    vb.name = environment_name
    vb.gui = false

    vb.memory = memsize
    vb.cpus = numvcpus
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provision :shell, inline: "yum -y update"
  config.vm.provision :shell, inline: "yum -y upgrade"
  #install docker engine, feel free to give custome version numbers otherwise it'll install the latest
  config.vm.provision :shell, inline: "yum -y install docker-engine"
  config.vm.provision :shell, inline: "systemctl enable docker.service"
  config.vm.provision :shell, inline: "systemctl start docker.service"
  #install docker compose
  config.vm.provision :shell, inline: "curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose"
  config.vm.provision :shell, inline: "chmod +x /usr/local/bin/docker-compose"
  config.vm.provision :shell, inline: "anutosh/my_project/vagrant/Docker-Nginx.sh" #to create Dockerimage, launch new container from it.
  end