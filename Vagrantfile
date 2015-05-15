# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

base_dir = File.expand_path(File.dirname(__FILE__))
conf = YAML.load_file(File.join(base_dir, "vagrant.yml"))

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # if you want to use vagrant-cachier,
  # please install vagrant-cachier plugin.
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.enable :apt
  end

  # throw error if vagrant-hosts not installed
  unless Vagrant.has_plugin?("vagrant-hosts")
    raise "vagrant-hosts plugin not installed"
  end

  config.vm.box = conf['base_box']

  # Machine settings
  node = {
    :hostname        => "machine1",
    :ip              => conf["machine1_ip"],
    :mem             => conf['machine_mem'],
    :cpus            => conf['machine_cpus'],
  }

  ansible_groups = {
    "test_machine"  => ["machine1"],
  }

  # Make sure docker is up and running.
  $docker_enabler = <<SCRIPT
sudo rm -rf /etc/init.d/docker.overide
if [ ! -f /var/run/docker.pid ]; then
    sudo start docker
fi
SCRIPT

  config.vm.define node[:hostname] do |cfg|
    cfg.vm.provider :virtualbox do |vb, override|
      override.vm.hostname = node[:hostname]
      override.vm.network :private_network, :ip => node[:ip]
      override.vm.provision :hosts
      vb.name = 'vagrant-mesos-' + node[:hostname]
      vb.customize ["modifyvm", :id, "--memory", node[:mem], "--cpus", node[:cpus] ]

      override.vm.provision "shell", inline: $docker_enabler 

      override.vm.provision "ansible" do |ansible|
        ansible.playbook = conf["ansible_playbook"]
        ansible.sudo = true
        ansible.verbose = '-vvvv'
        ansible.extra_vars = {
          server_spec_machine: 'enabled',
          marathon_zk_url: "zk://" + node[:ip] + ":2181", # Any fake ip
          marathon_hostname: node[:ip],
        }
        ansible.groups = conf["ansible_groups"]
      end
    end
  end

  # If you want to use a custom `.dockercfg` file simply place it
  # in this directory.
  if File.exist?(".dockercfg")
    config.vm.provision :shell, :priviledged => true, :inline => <<-SCRIPT
      cp /vagrant/.dockercfg /root/.dockercfg
      chmod 600 /root/.dockercfg
      chown root /root/.dockercfg
    SCRIPT
  end
end
